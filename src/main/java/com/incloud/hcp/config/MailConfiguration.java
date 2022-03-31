package com.incloud.hcp.config;

//@Component("mailConfig")
public class MailConfiguration {

	/*@Bean
	public JavaMailSender getMailSender(Map<String, Object> smtpMapa) {
		JavaMailSenderImpl mailSender = new JavaMailSenderImpl();

		mailSender.setDefaultEncoding("UTF-8");
		mailSender.setHost(smtpMapa.get("host").toString());
		mailSender.setPort(Integer.valueOf(smtpMapa.get("port").toString()));
		mailSender.setUsername(smtpMapa.get("remitentEmail").toString());
		mailSender.setPassword(smtpMapa.get("password").toString());


		Properties javaMailProperties = new Properties();
		javaMailProperties.put("mail.smtp.starttls.enable", "true");
		javaMailProperties.put("mail.smtp.auth", "true");
		javaMailProperties.put("mail.transport.protocol", "smtp");
		javaMailProperties.put("mail.debug", "false");

		mailSender.setJavaMailProperties(javaMailProperties);
		return mailSender;
	}

	//TODO: TEMPORAL
	@Bean
	public JavaMailSender getMailSender() {
		JavaMailSenderImpl mailSender = new JavaMailSenderImpl();

		mailSender.setDefaultEncoding("UTF-8");
		mailSender.setHost("smtp.office365.com");
		mailSender.setPort(Integer.valueOf(587));
		mailSender.setUsername("notificaciones@gruposilvestre.com.pe");
		mailSender.setPassword("Grup0$1lv$$7r3!1Prov1d3r");


		Properties javaMailProperties = new Properties();
		javaMailProperties.put("mail.smtp.starttls.enable", "true");
		javaMailProperties.put("mail.smtp.auth", "true");
		javaMailProperties.put("mail.transport.protocol", "smtp");
		javaMailProperties.put("mail.debug", "false");
		javaMailProperties.put("mail.smtp.host", "smtp.hornet.email");

		mailSender.setJavaMailProperties(javaMailProperties);
		return mailSender;
	}*/

}
