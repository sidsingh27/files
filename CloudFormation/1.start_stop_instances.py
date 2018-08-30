# instance.py
#!/bin/python
import argparse
import sys
import boto.ec2

def check_arg(args=None):
    parser = argparse.ArgumentParser(description='args : start/start, instance-id')
    parser.add_argument('-o', '--op',
                        help='operation type',
                        required='True',
                        default='stop')
    parser.add_argument('-i', '--iid',
                        help='instance id',
                        required='True',
                        default='')

    results = parser.parse_args(args)
    return (results.op,
            results.iid)

def manage_instance(op,iid):
    instance_id = []
    instance_id.append(unicode(iid))
    conn = boto.ec2.connect_to_region('us-east-1')
    #print 'conn=',conn
    if op == 'stop':
        #print 'stop: instance_id=',instance_id
        conn.stop_instances(instance_id,False)

    elif op == 'start':
        #print 'start: instance_id=',instance_id
        conn.start_instances(instance_id)
    else:
        #print 'else'
        pass

if __name__ == '__main__':
    '''
    Input : instance id & operation
    How it works : should work with cron on srv-01-0001-instance-manager. For example,
         0 7 * * *  /usr/bin/python /home/ubuntu/EC2/instance.py -i i-k172af8d -o start 
         0 11 * * *  /usr/bin/python /home/ubuntu/EC2/instance.py -i i-k172af8d -o stop
    '''
    op, iid = check_arg(sys.argv[1:])
    #print 'op=',op,'  iid=',iid
    manage_instance(op,iid)