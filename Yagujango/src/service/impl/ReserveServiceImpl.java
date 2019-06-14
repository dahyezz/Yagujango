package service.impl;


import java.io.File;
import java.io.UnsupportedEncodingException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.NoSuchProviderException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import dao.face.MemberDao;
import dao.face.ReserveDao;
import dao.impl.MemberDaoImpl;
import dao.impl.ReserveDaoImpl;
import dto.Match;
import dto.Member;
import dto.Reserve;
import dto.Seat;
import dto.Stadium;
import dto.Ticket;
import net.sourceforge.barbecue.Barcode;
import net.sourceforge.barbecue.BarcodeException;
import net.sourceforge.barbecue.BarcodeFactory;
import net.sourceforge.barbecue.BarcodeImageHandler;
import net.sourceforge.barbecue.output.OutputException;
import service.face.ReserveService;
import util.MailAuth;

public class ReserveServiceImpl implements ReserveService{
	private ReserveDao reserveDao = new ReserveDaoImpl();
	private MemberDao memberDao = new MemberDaoImpl();
	
	@Override
	public Stadium getStadiumcode(HttpServletRequest request) {
		String param = request.getParameter("stadium_code");
		int stadiumcode = 0;
		if( param != null && !"".equals(param)) {
			stadiumcode = Integer.parseInt(param);
		}
		
		Stadium stadium =  new Stadium();
		stadium.setStadium_code(stadiumcode);
		
		return stadium;
	}
	
	@Override
	public List<Stadium> getList() {
		return reserveDao.selectAllStaidum();
	}
	
	@Override
	public List<Match> getMatchList(Stadium stadium) {
		return reserveDao.selectAllByStadiumcode(stadium);
	}

	@Override
	public Match getMatchCode(HttpServletRequest request) {
		String param = request.getParameter("match_code");
		int match_code = 0;
		if( param != null && !"".equals(param)) {
			match_code = Integer.parseInt(param);
		}
		
		Match match = new Match();
		match.setMatch_code(match_code);
		
		return match;
	}

	@Override
	public Match getMatchInfo(Match match) {
		return reserveDao.selectMatchByMatchCode(match);
	}

	@Override
	public Stadium getStadiumInfo(Match match) {
		return reserveDao.selectStadiumByHometeamCode(match);
	}

	@Override
	public List<Seat> getSeatInfo(Match match) {
		
		return reserveDao.selectEmptySeatByMatchCode(match);
	}

	@Override
	public List<Ticket> getReserveStatus(Match match) {
		return reserveDao.selectAllTicketByMatchCode(match);
	}

	@Override
	public List<Ticket> getSelectSeatTicketinfo(Match match, int count) {
		
		return reserveDao.selectTicketInfo(match, count);
	}
	@Override
	public List<Seat> getSelectSeatInfo(List<Ticket> ticketinfo, int count) {
		
		List<Seat> seatList = new ArrayList<Seat>();
		
		for(int i=0; i<count; i++) {
			Seat seat = new Seat();
			seat = reserveDao.selectSeatInfo(ticketinfo.get(i).getSeat_code());
			
			seatList.add(seat);
		}
		
		return seatList;
	}

	@Override
	public List<Integer> getSeatCount(Match match) {
		List<Seat> seatcount = reserveDao.selectEmptySeatByMatchCode(match);
		
		List<Integer> seatCountList = new ArrayList<Integer>();
		int[] seatCountArray = new int[5];
		
		for(Seat e : seatcount) {
			
			if(e.getSeat_block().equals("A")) {
				seatCountArray[0]++;
			} else if(e.getSeat_block().equals("B")) {
				seatCountArray[1]++;
			} else if(e.getSeat_block().equals("C")) {
				seatCountArray[2]++;
			} else if(e.getSeat_block().equals("D")) {
				seatCountArray[3]++;
			} else if(e.getSeat_block().equals("E")) {
				seatCountArray[4]++;
			}
			
		}
		
		for(int i=0; i<seatCountArray.length;i++)
			seatCountList.add(seatCountArray[i]);
		
		return seatCountList;
	}



	public void insertReserve(HttpServletRequest request) {
		String deleteparam = request.getParameter("deleteparam");
		System.out.println(deleteparam);
		String cnt = request.getParameter("count"); // 내가 고른 티켓매수
		
		if(deleteparam.equals("insert")) { // parameter가 insert일 경우 reserve테이블 삽입
			Reserve reserve = new Reserve();
			int ticketcnt = Integer.parseInt(cnt);
			String memberno = request.getParameter("userno");
			String match = request.getParameter("match_code");
			String payment = request.getParameter("payment");

			// - - - match_date 변환 하는 부분 - - - 
			Match matchdt = new Match();
			matchdt.setMatch_code(Integer.parseInt(match));
			matchdt = reserveDao.selectMatchByMatchCode(matchdt);
			String stringdate = formatdate(matchdt);
			stringdate = stringdate.substring(0,10);
			stringdate = stringdate.replace("-", "");
			System.out.println("stringdate : " + stringdate);
			// - - - - - - - - - - - - - - - - - - - - -
		
			String receive = request.getParameter("receive");
			String[] Arrayticket = request.getParameterValues("ticket_code"); // 내가고른 좌석이 여러개일 경우 티켓코드는 여러개 생성 -> 배열로 방아와야함
			
			for(int i=0; i < ticketcnt; i++) {
				int userno = Integer.parseInt(memberno);
				reserve.setTicket_code(Integer.parseInt(Arrayticket[i]));
				reserve.setPayment(payment);
				reserve.setUserno(userno);
				reserve.setHow_receive(receive);

				reserveDao.insertReserve(reserve, stringdate, match, userno);
				
				//----- 바코드 생성 ------
				//	receive 가 바코드발급일때
				if(receive.equals("바코드발급")) {

					String barcode = stringdate+match+memberno;
					createBarcode(barcode+i, request);
					reserveDao.updateBarcode(reserve, barcode+i);
				}
			}
			
		}

	}
	
	@Override
	public void createBarcode(String bar, HttpServletRequest request) {
		
		DiskFileItemFactory factory = null;
		factory = new DiskFileItemFactory();

		// 3. 업로드된 아이템이 용량이 적당히 작으면 메모리에서 처리
		int maxMem = 1 * 1024 * 1024; // 1MB
		factory.setSizeThreshold(maxMem);
		// 4. 용량이 적당히 크면 임시파일 만들어서 처리(디스크)
		ServletContext context = request.getServletContext();

		File repository = new File(context.getRealPath("tmp"));
//		System.out.println(repository);
//		System.out.println(repository.exists());

		factory.setRepository(repository);
		// 5. 업로드 허용 기준을 넘지 않을 경우에만 파일 업로드 처리
		int maxFile = 10 * 1024 * 1024; // 10MB
		ServletFileUpload upload = null;
		upload = new ServletFileUpload(factory);

		upload.setFileSizeMax(maxFile);

		
		// - - - 바코드 생성 - - -
		try {
			Barcode barcode = BarcodeFactory.createCode128B(bar);
			barcode.setBarHeight(80);
			
			File file = new File(context.getRealPath("barcode")+"/"+bar+".png");

			BarcodeImageHandler.savePNG(barcode, file);
			
		} catch (BarcodeException e) {
			e.printStackTrace();
		} catch (OutputException e) {
			e.printStackTrace();
		}
		
	}

	@Override
	public Member getUserNo(String userid) {
		return reserveDao.getUserNo(userid);
	}

	@Override
	public Date StringToDate(String payment_date) {
		DateFormat transFormat = new SimpleDateFormat("yyyy-MM-dd");
		Date to = null;
		java.sql.Date sqlDate = null;
		try {
			to = transFormat.parse(payment_date);
			sqlDate = convert(to);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return sqlDate;
	}
	
	///////////////////// java.util.date -> java.sql.date /////////////////////
	private java.sql.Date convert(java.util.Date uDate) {
        java.sql.Date sDate = new java.sql.Date(uDate.getTime());
        return sDate;
	}
	

   @Override
	public List<Integer>  addTicket(Match match, String selectseat) {
      
	   String[] seatList = selectseat.split(",");
	   List	<Integer> newTicketList = new ArrayList<Integer>();
      
	   for(String e : seatList) {
		String seat_block = e.substring(0,1);
		String seatnumber = e.substring(e.lastIndexOf("_")+1);
		int seat_number = Integer.parseInt(seatnumber);
         
        //seat_code 알아오기
        int seat_code = reserveDao.selectSeatcodeBySeatInfo(seat_block, seat_number);
//	    System.out.println("seat_code : " + seat_code); //TEST
        reserveDao.insertTicket(match, seat_code); 
         
        int ticket_code = reserveDao.selectNewTicketCode(match, seat_code);
//	    System.out.println(ticket_code);
        newTicketList.add(ticket_code);
      }
	  return newTicketList;
   }

	@Override
	public void deleteTicket(HttpServletRequest request) {

		String ticketcd = request.getParameter("ticket_code");
		int ticketcode = Integer.parseInt(ticketcd);
		
		String cnt = request.getParameter("count");
		int count = Integer.parseInt(cnt);
		
		for(int i=0; i < count; i++) {
			reserveDao.deletetSeatInfoByTicket(ticketcode);
			ticketcode++;
		}
	}
		

	public void deletetSeatInfoByTicket(HttpServletRequest request) { // 결제취소버튼 삭제
		String deleteparam = request.getParameter("deleteparam");
		String cnt = request.getParameter("count"); // 내가 고른 티켓매수
		String ticketcd = request.getParameter("ticket_code"); // 삭제용 ticket_code
		System.out.println("삭제");
		int ticketcod = Integer.parseInt(ticketcd);
		int count = Integer.parseInt(cnt);
		
		if(deleteparam.equals("delete")) { // parameter가 delete일 경우 ticket테이블 삭제
			for(int i = ticketcod; i < ticketcod+count; i++) {
				reserveDao.deletetSeatInfoByTicket(i); // ticket테이블 삭제
			}
		}

	}
	
	@Override
	public List<Seat> getResevedSeatList(Match match) {
		reserveDao.optimizeSeat();
		
		return reserveDao.getReservedSeatListByMatchCode(match);
	}
	
	@Override
	public List<Seat> getAllSeat() {
		return reserveDao.selectAllSeat();
	}


	@Override
	public Member getMember(int memno) {
		return reserveDao.getMember(memno);
	}

	@Override
	public void sendEmail(HttpServletRequest request) {

		String username = request.getParameter("username");
//		System.out.println(username);
		final String PAYMENT = request.getParameter("payment");
		final String ACCOUNT_NAME = request.getParameter("account_number");
		final String BANK = request.getParameter("bank");
		final String PAY = request.getParameter("pay");
		
		//FROM 
		final String FROM = "yagujango123@gmail.com";
		final String FROMNAME = "야구장고";
		
		//TO
		final String TO = request.getParameter("email");
		 
		final String SUBJECT = "[(주)야구장고] " + username + "님, 예매가 완료되었습니다.";
		
		final String BODY_CARD = String.join(
				"<h5>안녕하세요. " + username + "님!<br>예매가 성공적으로 완료되었습니다.</h5>",
				"<p>예매관련 정보와 예매 안내 사항은 야구장고 마이페이지를 참조하여주십시오.</p>");
		final String BODY_PAY = String.join(
				"<h5>안녕하세요. " + username + "님!<br>예매가 성공적으로 완료되었습니다.</h5>",
				"<p>예매관련 정보와 예매 안내 사항은 야구장고 마이페이지를 참조하여주십시오.</p>",
				"입금하실은행은" + BANK + " 계좌번호는" + ACCOUNT_NAME + "입니다.",
				"총 결제금액은 " + PAY + "원 입니다.");
		
		Authenticator auth = new MailAuth("yagujango123@gmail.com", "1q2w3e!!");
		
		Properties props = System.getProperties();
		props.put("mail.smtp.starttls.enable", "true");
		props.put("mail.smtp.host", "smtp.gmail.com");
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.port", "587");

		Session session = Session.getDefaultInstance(props, auth);
		MimeMessage msg = new MimeMessage(session);
		
		try {
			msg.setFrom(new InternetAddress(FROM, FROMNAME));
			msg.setRecipient(Message.RecipientType.TO, new InternetAddress(TO));
			msg.setSubject(SUBJECT);
			if(PAYMENT.equals("무통장입금")) {
				msg.setContent(BODY_PAY, "text/html;charset=utf-8");
			} else {
				msg.setContent(BODY_CARD, "text/html;charset=utf-8");
			}
			System.out.println("Sending...");

			//메시지 보내기
			Transport.send(msg);
			
			System.out.println("Email sent!");

		} catch (NoSuchProviderException e) {
			e.printStackTrace();
			
		} catch (MessagingException e) {
			e.printStackTrace();
			
			System.out.println("The email was not sent.");
			System.out.println("Error message: " + e.getMessage());
			
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
	}

	
	@Override
	public List<Match> getThreeDaysMatchList(int i) {
		
		List<Match> matchList = reserveDao.selectThreeMatchList(3);
		System.out.println(matchList.size());
		
		if(matchList.size()==15)
			return matchList;
		else {
			matchList = reserveDao.selectThreeMatchList(4);
			return matchList;
		}
	}

	@Override
	public String formatdate(Match match) {
		Date datefrom = match.getMatch_date();
		SimpleDateFormat datetransFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String dateto = datetransFormat.format(datefrom);

		return dateto;
	}

	@Override
	public List<String> formatdatelist(List<Match> matchList) {
		List date = new ArrayList();
		
		for(int i = 0; i < matchList.size(); i++) {
			Date datefrom = matchList.get(i).getMatch_date();
			SimpleDateFormat datetransFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
			String dateto = datetransFormat.format(datefrom);
			dateto = dateto.replaceAll("-", "");
			dateto = dateto.replaceAll(":", "");
			dateto = dateto.replaceAll(" ", "");
			
			date.add(dateto);

		}
		return date;
	}

}
