#!/bin/python
import os
import sys
import boto
import boto.ec2
import time

AWS_ACCESS_KEY = boto.config.get('Credentials', '')
AWS_ACCESS_SECRET_KEY = boto.config.get('Credentials', '')

conn = boto.ec2.connect_to_region("us-east-1")

#### creating a new instance ####
new_reservation = conn.run_instances("ami-55ef662f",
    key_name="lamp2",
    instance_type="t2.micro",
    security_group_ids=["sg-4504290e"])

instance = new_reservation.instances[0]

conn.create_tags([instance.id], {"Name":"srv1"})
while instance.state == u'pending':
    print "Instance state: %s" % instance.state
    time.sleep(10)
    instance.update()

print "Instance state: %s" % instance.state
print "Public dns: %s" % instance.public_dns_name

#### Create a volume ####
# create_volume(size, zone, snapshot=None, volume_type=None, iops=None)
vol = conn.create_volume(10, "us-east-1b")
print 'Volume Id: ', vol.id

# Add a Name tag to the new volume so we can find it.
conn.create_tags([vol.id], {"Name":"rns-volume"})

# We can check if the volume is now ready and available:
curr_vol = conn.get_all_volumes([vol.id])[0]
while curr_vol.status == 'creating':
      curr_vol = conn.get_all_volumes([vol.id])[0]
      print 'Current Volume Status: ', curr_vol.status
      time.sleep(2)
print 'Current Volume Zone: ', curr_vol.zone

#### Attach a volume ####
result = conn.attach_volume (vol.id, instance.id, "/dev/sdf")
print 'Attach Volume Result: ', result
