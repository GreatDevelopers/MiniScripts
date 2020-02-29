maxload=3.0
load=`w | head -n1 | awk '{print$10}' | cut -d"," -f1`
server="smtp.gmail.com"
port=587
from="UptimeSuhel@gmail.com"
to="<Send mail to>"
username="<Username goes here>"
password="<password goes here>"
subject="Server needs attention"
message="This is to inform to admin that code server load is $load and immediate action is required!!!"

if (( $(echo "$load > $maxload" |bc -l) )); then
        sendemail -t $to -s $server:$port -f $from -xu $username -xp $password -u $subject -m $message
fi
