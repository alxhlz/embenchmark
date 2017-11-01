#!/bin/bash


############################################################
# Installation von "dialog"
#

if [ -d "/etc/apt" ]; then
	pmgr=apt
fi
if [ -d "/etc/yum" ]; then
	pmgr=yum
fi

if [ $pmgr == "apt" ]; then
	apt-get install dialog -y
fi
if [ $pmgr == "yum" ]; then
	yum install dialog -y
fi


############################################################
# Variablen
#


do_informations=0
do_network=0
do_io=0
do_cpu=0
network_1=0
network_2=0
network_3=0
network_4=0
network_5=0
network_6=0
network_7=0
network_8=0
network_9=0
network_10=0
network_11=0
network_12=0
network_13=0
network_14=0
network_15=0
network_16=0
network_17=0
network_18=0
network_19=0
network_20=0
network_21=0
network_22=0


############################################################
# Menue
#

cmd=(dialog --separate-output --checklist "Please choose your options." 22 76 16)
options=(1 "System informations" on
         2 "Network benchmark" on
         3 "I/O performance" on
         4 "CPU benchmark" on)
main=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
clear
for choice in $main
do
    case $choice in
        1)
			do_informations=1
            ;;
        2)
			cmd=(dialog --separate-output --checklist "Here you can check your prefered locations for testing the network connection." 22 76 16)
			options=(1  "OVH (FR) - 100MB" on
					 2  "IP-Projects (DE) - 100MB" on
					 3  "combahton (DE) - 100MB" off
					 4  "meerfabig (DE) - 1GB" off
					 5  "myloc (DE) - 100MB" off
					 6  "FSIT (CH) - 100MB" off
					 7  "Leaseweb (DE) - 100MB" on
					 8  "Leaseweb (US) - 100MB" off
					 9  "Leaseweb (NL) - 100MB" off
					 10 "Leaseweb (SG) - 100MB" off
					 11 "Softlayer (NL) - 100MB" off
					 12 "Softlayer (CN) - 100MB" off
					 13 "Softlayer (GB) - 100MB" off
					 14 "Softlayer (JP) - 100MB" off
					 15 "Softlayer (US) - 100MB" off
					 16 "Softlayer (CA) - 100MB" off
					 17 "Softlayer (DE) - 100MB" on
					 18 "EDIS (AT) - 100MB" off
					 19 "Linode (DE) - 100MB" off
					 20 "CacheFly (CDN) - 100MB" off
					 21 "Hetzner (DE) - 100MB" on
					 22 "myVirtualserver (DE) - 100MB" on
					)
			network=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
			clear
			for choice in $network
			do
				case $choice in
					1)
						network_1=1
						;;
					2)
						network_2=1
						;;
					3)
						network_3=1
						;;
					4)
						network_4=1
						;;
					5)
						network_5=1
						;;
					6)
						network_6=1
						;;
					7)
						network_7=1
						;;
					8)
						network_8=1
						;;
					9)
						network_9=1
						;;
					10)
						network_10=1
						;;
					11)
						network_11=1
						;;
					12)
						network_12=1
						;;
					13)
						network_13=1
						;;
					14)
						network_14=1
						;;
					15)
						network_15=1
						;;
					16)
						network_16=1
						;;
					17)
						network_17=1
						;;
					18)
						network_18=1
						;;
					19)
						network_19=1
						;;
					20)
						network_20=1
						;;
					21)
						network_21=1
						;;
					22)
						network_22=1
						;;
				esac
			done
			do_network=1
            ;;
        3)
            do_io=1
            ;;
        4)
			dialog --yesno "To run the CPU benchmark, we have to install a tool called 'bc'. Is this okay for you?" 7 60
			choice=$?
			clear
			if [ $choice = 0 ]
			then
			   do_cpu=1
			elif [ $choice = 1 ]
			then
			   do_cpu=0
			fi
            ;;
    esac
done


############################################################
# Installation von 'bc'
#


if [ $do_cpu = 1 ]
then
	if [ $pmgr = "apt" ]
	then
		apt-get install bc -y
	fi
	
	if [ pmgr  = "yum" ]
	then
		yum install bc -y
	fi
	
	clear
fi


############################################################
# ENSKY Media (www.ensky.media)
# Alexander Holzapfel
#

echo -e "\033[31mENSKY Media - Benchmark Script - Version 8.0 - 27.10.2017\033[0m"
echo -e "\033[32mhttps://github.com/enskymedia/embenchmark\033[0m"
echo -e "\033[32mSpecial thanks to: rawsan, perryflynn\033[0m"

############################################################
# Informationen
#
if [ $do_informations = 1 ]
then
	cname=$( awk -F: '/model name/ {name=$2} END {print name}' /proc/cpuinfo )
	cores=$( awk -F: '/model name/ {core++} END {print core}' /proc/cpuinfo )
	freq=$( awk -F: ' /cpu MHz/ {freq=$2} END {print freq}' /proc/cpuinfo )
	tram=$( free -m | awk 'NR==2 {print $2}' )
	swap=$( free -m | awk 'NR==4 {print $2}' )
	up=$(uptime -p)
	echo
	echo
	echo -e "\033[35mSystem informations \033[0m"
	echo
	echo -e "\033[36mCPU:\033[0m $cname"
	echo -e "\033[36mCPU cores:\033[0m $cores"
	echo -e "\033[36mClock speed per core:\033[0m $freq MHz"
	echo -e "\033[36mRAM:\033[0m $tram MB"
	echo -e "\033[36mSWAP:\033[0m $swap MB"
	echo -e "\033[36mUptime:\033[0m $up"
fi


############################################################
# Netzwerk Benchmark
#


if [ $do_network = 1 ]
then

	echo
	echo
	echo -e "\033[35mNetwork Benchmark \033[0m"
	echo
	
	#OVH (DE)
	if [ $network_1 = 1 ]
	then
		result=$( wget -O /dev/null http://proof.ovh.net/files/100Mb.dat 2>&1 | awk '/\/dev\/null/ {speed=$3 $4} END {gsub(/\(|\)/,"",speed); print speed}' )
		echo -e "\033[36mOVH(FR) - \033[33m100MB Testfile \033[0m: $result"
	fi	
	
	#IP Projects (DE)
	if [ $network_2 = 1 ]
	then
		result=$( wget -O /dev/null http://lg.ip-projects.de/100MB.test 2>&1 | awk '/\/dev\/null/ {speed=$3 $4} END {gsub(/\(|\)/,"",speed); print speed}' )
		echo -e "\033[36mIP-Projects(DE) - \033[33m100MB Testfile \033[0m: $result"
	fi

	#combahton (DE)
	if [ $network_3 = 1 ]
	then
		result=$( wget -O /dev/null http://lg.combahton.net/100MB.test 2>&1 | awk '/\/dev\/null/ {speed=$3 $4} END {gsub(/\(|\)/,"",speed); print speed}' )
		echo -e "\033[36mcombahton(DE) - \033[33m100MB Testfile \033[0m: $result"
	fi
	
	#meerfabig (DE)
	if [ $network_4 = 1 ]
	then
		result=$( wget -O /dev/null http://mirror.meerfarbig.io/testfiles/1G 2>&1 | awk '/\/dev\/null/ {speed=$3 $4} END {gsub(/\(|\)/,"",speed); print speed}' )
		echo -e "\033[36mmeerfabig(DE) - \033[33m1GB Testfile \033[0m: $result"
	fi
	
	#myloc (DE)
	if [ $network_5 = 1 ]
	then
		result=$( wget -O /dev/null http://speed.myloc.de/100MB.bin 2>&1 | awk '/\/dev\/null/ {speed=$3 $4} END {gsub(/\(|\)/,"",speed); print speed}' )
		echo -e "\033[36mmyloc(DE) - \033[33m100MB Testfile \033[0m: $result"
	fi
	
	#FSIT (CH)
	if [ $network_6 = 1 ]
	then
		result=$( wget -O /dev/null http://fsit.ch/speed/100mebibyte.dat 2>&1 | awk '/\/dev\/null/ {speed=$3 $4} END {gsub(/\(|\)/,"",speed); print speed}' )
		echo -e "\033[36mFSIT(CH) - \033[33m100MB Testfile \033[0m: $result"
	fi
	
	#Leaseweb (DE)
	if [ $network_7 = 1 ]
	then
		result=$( wget -O /dev/null http://mirror.de.leaseweb.net/speedtest/100mb.bin 2>&1 | awk '/\/dev\/null/ {speed=$3 $4} END {gsub(/\(|\)/,"",speed); print speed}' )
		echo -e "\033[36mLeaseweb(DE) - \033[33m100MB Testfile \033[0m: $result"
	fi
	
	#Leaseweb (US)
	if [ $network_8 = 1 ]
	then
		result=$( wget -O /dev/null http://mirror.us.leaseweb.net/speedtest/100mb.bin 2>&1 | awk '/\/dev\/null/ {speed=$3 $4} END {gsub(/\(|\)/,"",speed); print speed}' )
		echo -e "\033[36mLeaseweb(US) - \033[33m100MB Testfile \033[0m: $result"
	fi
	
	#Leaseweb (NL)
	if [ $network_9 = 1 ]
	then
		result=$( wget -O /dev/null http://mirror.nl.leaseweb.net/speedtest/100mb.bin 2>&1 | awk '/\/dev\/null/ {speed=$3 $4} END {gsub(/\(|\)/,"",speed); print speed}' )
		echo -e "\033[36mLeaseweb(NL) - \033[33m100MB Testfile \033[0m: $result"
	fi
	
	#Leaseweb (SG)
	if [ $network_10 = 1 ]
	then
		result=$( wget -O /dev/null http://mirror.sg.leaseweb.net/speedtest/100mb.bin 2>&1 | awk '/\/dev\/null/ {speed=$3 $4} END {gsub(/\(|\)/,"",speed); print speed}' )
		echo -e "\033[36mLeaseweb(SG) - \033[33m100MB Testfile \033[0m: $result"
	fi
	
	#Softlayer (NL)
	if [ $network_11 = 1 ]
	then
		result=$( wget -O /dev/null http://speedtest.ams01.softlayer.com/downloads/test100.zip 2>&1 | awk '/\/dev\/null/ {speed=$3 $4} END {gsub(/\(|\)/,"",speed); print speed}' )
		echo -e "\033[36mSoftlayer(NL) - \033[33m100MB Testfile \033[0m: $result"
	fi
	
	#Softlayer (CN)
	if [ $network_12 = 1 ]
	then
		result=$( wget -O /dev/null http://speedtest.hkg02.softlayer.com/downloads/test100.zip 2>&1 | awk '/\/dev\/null/ {speed=$3 $4} END {gsub(/\(|\)/,"",speed); print speed}' )
		echo -e "\033[36mSoftlayer(CN) - \033[33m100MB Testfile \033[0m: $result"
	fi
	
	#Softlayer (GB)
	if [ $network_13 = 1 ]
	then
		result=$( wget -O /dev/null http://speedtest.lon02.softlayer.com/downloads/test100.zip 2>&1 | awk '/\/dev\/null/ {speed=$3 $4} END {gsub(/\(|\)/,"",speed); print speed}' )
		echo -e "\033[36mSoftlayer(GB) - \033[33m100MB Testfile \033[0m: $result"
	fi
	
	#Softlayer (JP)
	if [ $network_14 = 1 ]
	then
		result=$( wget -O /dev/null http://speedtest.tok02.softlayer.com/downloads/test100.zip 2>&1 | awk '/\/dev\/null/ {speed=$3 $4} END {gsub(/\(|\)/,"",speed); print speed}' )
		echo -e "\033[36mSoftlayer(JP) - \033[33m100MB Testfile \033[0m: $result"
	fi
	
	#Softlayer (US)
	if [ $network_15 = 1 ]
	then
		result=$( wget -O /dev/null http://speedtest.wdc01.softlayer.com/downloads/test100.zip 2>&1 | awk '/\/dev\/null/ {speed=$3 $4} END {gsub(/\(|\)/,"",speed); print speed}' )
		echo -e "\033[36mSoftlayer(US) - \033[33m100MB Testfile \033[0m: $result"
	fi
	
	#Softlayer (CA)
	if [ $network_16 = 1 ]
	then
		result=$( wget -O /dev/null http://speedtest.tor01.softlayer.com/downloads/test100.zip 2>&1 | awk '/\/dev\/null/ {speed=$3 $4} END {gsub(/\(|\)/,"",speed); print speed}' )
		echo -e "\033[36mSoftlayer(CA) - \033[33m100MB Testfile \033[0m: $result"
	fi
	
	#Softlayer (DE)
	if [ $network_17 = 1 ]
	then
		result=$( wget -O /dev/null http://speedtest.fra02.softlayer.com/downloads/test100.zip 2>&1 | awk '/\/dev\/null/ {speed=$3 $4} END {gsub(/\(|\)/,"",speed); print speed}' )
		echo -e "\033[36mSoftlayer(DE) - \033[33m100MB Testfile \033[0m: $result"
	fi
	
	#EDIS (AT)
	if [ $network_18 = 1 ]
	then
		result=$( wget -O /dev/null http://at.edis.at/100MB.test 2>&1 | awk '/\/dev\/null/ {speed=$3 $4} END {gsub(/\(|\)/,"",speed); print speed}' )
		echo -e "\033[36mEDIS(AT) - \033[33m100MB Testfile \033[0m: $result"
	fi

	#Linode Frankfurt (DE)
	if [ $network_19 = 1 ]
	then
		result=$( wget -O /dev/null http://speedtest.frankfurt.linode.com/100MB-frankfurt.bin 2>&1 | awk '/\/dev\/null/ {speed=$3 $4} END {gsub(/\(|\)/,"",speed); print speed}' )
		echo -e "\033[36mLinode Frankfurt(DE) - \033[33m100MB Testfile \033[0m: $result"
	fi
	
	#CacheFly CDN 
	if [ $network_20 = 1 ]
	then
		result=$( wget -O /dev/null http://cachefly.cachefly.net/100mb.test 2>&1 | awk '/\/dev\/null/ {speed=$3 $4} END {gsub(/\(|\)/,"",speed); print speed}' )
		echo -e "\033[36mCacheFly CDN - \033[33m100MB Testfile \033[0m: $result"
	fi

	#Hetzner (DE)
	if [ $network_21 = 1 ]
	then
		result=$( wget -O /dev/null http://speed.hetzner.de/100MB.bin 2>&1 | awk '/\/dev\/null/ {speed=$3 $4} END {gsub(/\(|\)/,"",speed); print speed}' )
		echo -e "\033[36mHetzner (DE) - \033[33m100MB Testfile \033[0m: $result"
	fi

	#myVirtualserver (DE)
	if [ $network_22 = 1 ]
	then
		result=$( wget -O /dev/null https://lg-v4.vnetso.com/100MB.test 2>&1 | awk '/\/dev\/null/ {speed=$3 $4} END {gsub(/\(|\)/,"",speed); print speed}' )
		echo -e "\033[36mmyVirtualserver - \033[33m100MB Testfile \033[0m: $result"
	fi
fi


############################################################
# I/O Performance
# thanks to https://github.com/perryflynn/iobench/
#


if [ $do_io = 1 ]
then

	DIR="."
	ISSYNC=1
	ISREAD=1
	C=1024
	ISWRITE=1

    echo
	echo
    echo -e "\033[35mI/O Benchmark\033[0m"
	echo
	echo -e "\033[36mTarget directory:\033[0m $DIR"
	echo -e "\033[36mTestfile size:\033[0m $C x 1 Megabyte"
    echo

	tempfile() {
		echo -n "$DIR/$(mktemp -u iobench.XXXXXXXXXXX)"
	}

    echo -e "\033[36m[1] Write benchmark without cache\033[0m"

	TEMPF=$(tempfile)

	if [ "$ISWRITE" == "1" ] && [ "$ISSYNC" == "1" ]; then
		dd if=/dev/zero of="$TEMPF" bs=1M count=$C conv=fdatasync,notrunc 2>&1 | tail -n 1
		sleep 10
	elif [ "$ISWRITE" == "0" ]; then
		echo "skipped."
	else
		echo "skipped. use --sync option to enable."
	fi

	echo
	echo -e "\033[36m[2] Write benchmark with cache\033[0m"

	if [ "$ISWRITE" == "1" ]; then
		dd if=/dev/zero of="$TEMPF" bs=1M count=$C 2>&1 | tail -n 1
		sleep 10
	else
		echo "skipped."
	fi

	echo
	echo -e "\033[36m[3] Read benchmark with droped cache\033[0m"


	if [ -f "$TEMPF" ] && [ "$ISREAD" == "1" ] && [ "$ISSYNC" == "1" ]; then
		echo 3 > /proc/sys/vm/drop_caches
		dd if="$TEMPF" of=/dev/null bs=1M count=$C 2>&1 | tail -n 1
		sleep 10
	elif [ ! -f "$TEMPF" ]; then
		echo "No file for read tests found. skipped."
	elif [ "$ISREAD" == "0" ]; then
		echo "skipped."
	else
		echo "skipped. use --sync option to enable."
	fi

	echo
	echo -e "\033[36m[4] Read benchmark without cache drop\033[0m"

	if [ -f "$TEMPF" ] && [ "$ISREAD" == "1" ]; then
		for i in {1..5}; do
			echo -e "\033[33m[4.$i] Run $i of 5\033[0m"
			dd if="$TEMPF" of=/dev/null bs=1M count=$C 2>&1 | tail -n 1
		done
	elif [ ! -f "$TEMPF" ]; then
		echo "No file for read tests found. skipped."
	else
		echo "skipped."
	fi


	if [ -f "$TEMPF" ]; then
		rm "$TEMPF"
	fi
    
fi

############################################################
# CPU Benchmark
#


if [ $do_cpu = 1 ]
then
	echo
	echo
	echo -e "\033[35mCPU Benchmark\033[0m"
	time echo "scale=4000; a(1)*4" | erg=$(bc -l)
	echo
	echo
	
fi
