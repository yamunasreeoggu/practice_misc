function CertDetails {
  	PEM="$(cat)"
  	CertSN="$(print "$PEM" | openssl x509 -subject -serial -enddate -noout 2>\dev\null)"
  	CertExpD="$(print "$CertSN" | sed -n '$!d;s/.*=//;p')"
  	FoundCN="$(print "$CertSN" | sed -n 'ls/.*= *//;p')"
  	check SSLCert "$FoundCN $*"
  	CertSN="$(print "$CertSN" | sed -n 'ld;s/.*=//;p;q')"
}


function DTCertLogClean {
  check DTCertLogClean
  [ -z "$DTCertLog" ] && return
  print -n "Cleaning $DTCertLog "
  [ -w "$DTCertLog" ] && (> "$DTCertLog"; print "done") | | print "not found"
}



awk 'NR==1{print gensub(/.*\//,"appliance and queue manager name:",1,FILENAME)} 1' '{{item.path}}'

ed -s /home/myhome/certfile << 'EOF'
g/No Certs present/;-2+1d
w
EOF
