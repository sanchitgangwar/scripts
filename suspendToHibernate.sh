#! /bin/bash
# Script name: /etc/pm/sleep.d/0000suspendToHibernate
# Purpose: Auto hibernates after a period of sleep
# Edit the "autohibernate" variable below to set the number of seconds to sleep

curtime=$(date +%s)
autohibernate=3600
echo "$curtime $1" >> /tmp/autohibernate.log

if[ "$1" = "suspend" ]
then
	# Suspending. Record current time, and set a wake up timer.
	echo "$curtime" > /var/run/pm-utils/locks/suspendToHibernate.lock
	rtcwake -m no -s $autohibernate
fi

if[ "$1" = "resume" ]
then
	# Coming out of sleep.
	sustime=$(cat /var/run/pm-utils/locks/suspendToHibernate.lock)
	rm /var/run/pm-utils/locks/suspenToHibernate.lock

	# Did we wake up due to the rtc timer above?
	if [ $(($curtime - $sustime)) -ge $autohibernate ]
	then
		# Then hibernate
		rm /var/run/pm-utils/locks/pm-suspend.lock
		/usr/sbin/pm-hibernate
	else
		# Otherwise cancel the rtc timer and wake up normally.
		rtcwake -m no -s 1
	fi
fi
