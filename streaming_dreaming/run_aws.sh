# ssh parameters of the EC2 instance
pem=~/.ssh/aws_us_west.pem

# enter endless while loop
while true
do
    # check internet connection
    echo Checking internet connection...
    ping -t 5 8.8.8.8

    if [ $? -eq 0 ]
    then
        echo Internet connection is fine.

        # obtain ip address of EC2 server
        echo Fetching public IP of cloud server...
        pubip=$(echo $(aws ec2 describe-instances --instance-ids i-0269590f8ef0838a1 --query 'Reservations[0].Instances[0].PublicIpAddress'))
        publicip=$(echo "$pubip" | tr -d '"')
        if [ $? -eq 0 ]
        then
            echo The public IP address is $publicip

            # test whether SSH Tunnel can be established
            echo Testing SSH connection...
            if ssh -i $pem -Aqo StrictHostKeyChecking=no ubuntu@$publicip exit
            then
                echo SSH connection successful.

                # start frame generation and processing loop
                while [ $? -eq 0 ]
                do
                    # test if dream.py is running, start if it isnt
                    running=$(ssh -i $pem ubuntu@$publicip 'ps -p $(cat /home/ubuntu/tmp/dreaming.pid) >/dev/null; echo $?')
                    if [ $running -eq 0 ]
                    then
                        echo dream.py is running.
                    else
                        echo dream.py is not running!!
                        #ssh -i $pem ubuntu@$publicip '. /home/ubuntu/.bashrc-anaconda2.bak;. /home/ubuntu/.bash_history;. /home/ubuntu/.bash_logout;. /home/ubuntu/.bashrc;. /home/ubuntu/.profile;/home/ubuntu/anaconda2/bin/python /home/ubuntu/dream.py'
                    fi

                    #create screenshot
                    #touch input/frame.jpg

                    #push frame
                    echo Pushing frames from input to cloud server...
                    scp -i $pem -ro ConnectTimeout=30 "input" ubuntu@$publicip:~/
                    #rm -f input/*.jpg
                    if [ $? -eq 0 ]
                    then
                        echo Frames pushed. Waiting...
                        sleep 15
                    else
                        echo Unable to push frames.
                        break
                    fi

                    # pull frame
                    echo Pulling frames from cloud server...
                    scp -i $pem -ro ConnectTimeout=30 "ubuntu@$publicip:~/output" .
                    if [ $? -eq 0 ]
                    then
                        echo Frames pulled. Deleting Frames from remote...
                        ssh -i $pem -Aq ubuntu@$publicip 'rm ~/output/*'
                        echo Frames removed.
                    else
                        echo Unable to pull frames.
                        break
                    fi
                done
                echo Connection interrupted.
            else
                echo SSH connection unsuccessful.
            fi
        else
            echo Unable to fetch server IP. Server is probably stopped.
        fi
    else
        echo No internet connection.
        sleep 3
    fi
done


