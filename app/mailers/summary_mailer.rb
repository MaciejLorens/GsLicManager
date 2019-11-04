class SummaryMailer < ActionMailer::Base

	def en_summary_created(mail_to, user_email,
                        company_name, app_name, 
                        version_name, user_license)

		@mail_to = mail_to
		@user_email = user_email
		if company_name != nil
			@company_name = company_name
		else
			@company_name = 'Individual client'
		end
		@app_name = app_name
		@version_name = version_name
		@user_license = user_license
		lic_type_id = user_license.license_type_id
		lic_type = LicenseType.where(id: lic_type_id).pluck(:val_en)
		@license_type = lic_type[0]

		mail_from = Config.where(key: 'sender_email').pluck(:value_str2)
		mail_from = mail_from[0]

		mail_subject = Config.where(key: 'sender_email').pluck(:value_str3)
		mail_subject = mail_subject[0]

		mail(
				to: mail_to,
				from: mail_from,
				subject: mail_subject
				# from: 'office@gs-software.pl',
				# subject: 'TEST'
			)
	end

	def pl_summary_created(mail_to, user_email,
                        company_name, app_name, 
                        version_name, user_license)
		mail_to = mail_to
		@user_email = user_email
		if company_name != nil
			@company_name = company_name
		else
			@company_name = 'Klient indywidualny'
		end
		@app_name = app_name
		@version_name = version_name
		@user_license = user_license
		lic_type_id = user_license.license_type_id
		lic_type = LicenseType.where(id: lic_type_id).pluck(:val_en)
		@license_type = lic_type[0]

		mail_from = Config.where(key: 'sender_email').pluck(:value_str2)
		mail_from = mail_from[0]

		mail_subject = Config.where(key: 'sender_email').pluck(:value_str4)
		mail_subject = mail_subject[0]

		mail(
				to: mail_to,
				from: mail_from,
				subject: mail_subject
				# from: 'office@gs-software.pl',
				# subject: 'TEST'
			)
		
	end

end