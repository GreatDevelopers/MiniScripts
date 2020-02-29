## sendmail.sh

#### Required Packages
1. sendemail

#### Installation
1. Install required packages using following command:

      sudo apt install sendemail

2. Edit sendmail.sh file and fill required credentials for email configuration.
If you are using gmail to send email, then make sure to allow the login access
through less secure apps by visiting at https://myaccount.google.com/security

3. To run it as a crontab after every 5 minute, add following line:

      */5 * * * * /bin/bash /<path_to_script>

  in file by running command:

      sudo crontab -e

4. Restart crontab service by running command:

      sudo systemctl restart cron
