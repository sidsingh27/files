#!/bin/python
import boto.ec2

# production instances
production = [
    'srv1', 
    ]
# 'srv2', 'srv3', 'srv4', 'srv5', 'srv6', 'srv7', 'srv9', 'srv9',

# currently using this mandrill smtp
def send_alert_mandrill(message):
    import smtplib
    from email.mime.multipart import MIMEMultipart
    from email.mime.text import MIMEText

    msg = MIMEMultipart('alternative')

    msg['Subject'] = "AWS Alert: stopped production instance"
    msg['From']    = "devopstestmail@gmail.com"
    msg['To']      = "devopstestmail@gmail.com"

    text = message
    part1 = MIMEText(text, 'plain')

    html = message
    part2 = MIMEText(html, 'html')

    username = "devopstestmail@gmail.com"
    password = "devopstestmail09"

    msg.attach(part1)
    msg.attach(part2)

    s = smtplib.SMTP('smtp.gmail.com:587')
    s.starttls()
    s.login(username, password)
    s.sendmail(msg['From'], msg['To'], msg.as_string())
    s.quit()

# polling all instances
# if the stopped instance is for production, sends an alert email with instance info
def polling():
    conn = boto.ec2.connect_to_region('us-east-1')
    reservations = conn.get_all_reservations()

    for r in reservations:
        for i in r.instances:
            if 'Name' in i.tags:
               # check a stopped instance is for production
               if i.state == 'stopped' and i.tags['Name'] in production:
                  # if it is, sends an alert email
                  print "production:  %s (%s) [%s]" % (i.tags['Name'], i.id, i.state)
                  message = str(i.tags['Name']) + ' (' + str(i.id) + ') ' + '[' + str(i.state) + ']'
                  send_alert_mandrill(message)
               else:
                  print "Non-production:  %s (%s) [%s]" % (i.tags['Name'], i.id, i.state)

            else:
               print "%s [%s]" % (str(i.tags['Name']), i.state)

if __name__ == '__main__':
    '''
    How it works : should work with cron. For example,
    */30 * * * *  /usr/bin/python /home/ubuntu/EC2/detecting_stopped_production_instances.py
    '''
    polling()
