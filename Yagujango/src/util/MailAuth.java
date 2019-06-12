package util;

import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;

public class MailAuth extends Authenticator {

	// 구글 SMTP ID
	private String smtp_username = "yagujango123@gmail.com";

	// 구글 SMTP PW
	private String smtp_password = "1q2w3e!!";

	// 인증 객체
	private PasswordAuthentication pa;
	
	public MailAuth(String smtp_username, String smtp_password) {
		this.smtp_username = smtp_username;
		this.smtp_password = smtp_password;
		
		pa = new PasswordAuthentication(smtp_username, smtp_password);
	}
	
	@Override
	protected PasswordAuthentication getPasswordAuthentication() {
		return pa;
	}
}
