# devops-interview


What do the following commands do and how would you use them?
● tee
command is used to copy/store and view the output of any other command to a files
e.g: 
view all new log lines and store them in allLog.log
tail -f *log | tee allLog.log

● awk

designed to execute complex pattern-matching operations on streams of textual data. It makes heavy use of strings, associative arrays, and regular expressions, and is immensely useful for parsing system data and generating automatic - similar to sed 

    $ awk '{ print $2, $1 }' data.txt

● tr
The tr utility copies the standard input to the standard output with substitution or deletion of selected characters
e.g: get list of changed files in last commit in List 
`git show --pretty="" --no-commit-id --diff-filter=AMRC  --name-only `git log --format="%H" -n 1` | tr -s "\n" " "` 

● cut
Remove or "cut out" sections of each line of a file, list or files . and show it in output

● tac
Concatenate and print files in reverse. reverse of cat
  uses it on debug log files to show last entries in a reverse mode: 
 tail /var/log/auth.log | tac 

● curl
curl is a tool to transfer data from or to a server, using one of the supported protocols (HTTP, HTTPS, FTP, FTPS, SCP, SFTP, TFTP, DICT, TELNET, LDAP or FILE). The command is designed to work without user interaction.
Used to fetch some API : AWS / GITHUB ...
fetch the PR 1000 from github / then get base of the of PR using python parser. 
`curl --user "user:pass" -s 'https://api.github.com/repos/owner/myrepo/pulls/1000' | python -c "import sys, json; print json.load(sys.stdin)['base']['ref']" `

● wget
wget is a free utility for non-interactive download of files from the web (HTTPS / HTTP / FTP )
   ` wget http://mysite.com/files/installer.zip`

● watch
watch is used to run any designated command at regular intervals
used to check if a service is running  or checking free disk ...
e.g: `watch -d -n 10 df -h // check df -h every 10 sec`

● head
prints the first 10 lines of each FILE to standard output
   head test.log

● tail
   tail last 10 lines of each file, using with -f update output periodically. used to debug a specific behavior of application. 
   e.g: show all request sent to nginx servers to see which errors occured, with *log it will glob access and error log of nginx. 
   ` tail -f /var/log/nginx/*log  `


 ●   Explanation OF : ( `date ; ps -ef | awk '{print $1}' |
 sort | uniq | wc -l ) >> Activity.log `

date : show current date. 
ps -ef : show all process status, with -f will show Display the uid, pid, parent pid, ... 
with awk '{print $1}' will show first element which uid, then with sort and uniq remove duplicate UID. Then finally wc -l will show number of line and redirect the resule to Activity.log. 
==> the command will show number of active UID at specific date : 
``` 
Tue Feb 14 09:09:24 GST 2017
      23
```

HTTP How it works : 

HTTP stands for Hypertext Transfer Protocol. It's the network protocol used to deliver virtually all files and other data on the World Wide Web. 
HTTP uses the client-server model: An HTTP client [browser] opens a connection and sends a request message [the request and headers] to an HTTP server [Apache or nginx]; the server then returns a response message, HTTP is application level protocol because it sits on top of the TCP layer. and it use TCP connection to connect to HTTP server.

Mainly HTTP client send REQUEST [ HTTP Request Method , Domain, Requested path/page ], Based on DNS lookup it will retrieve IP of HTTP Server, then send HTTP REQUEST, HTTP Server will receive Request and breaks down the request to fetch Methode [PUT, GET , POST] and Domain [mysite.com] and path [/list/users.php], 
The server verifies that there is a Virtual Host configured on the server that corresponds with domain [mysite.com], The server verifies that it accept Method [GET] , and If the server has a rewrite module installed, it will use rule to rewrite the request. The server goes to pull the content that corresponds with the request, and streams the output to the client.   


How we parse web page in browser:

- If the URL contains a domain name, the browser first connects to a domain name server and retrieves the corresponding IP address for the web server.
- The web browser connects to the web server and sends an HTTP request (via the protocol stack) for the desired web page.
- The web server receives the request and checks for the desired page. If the page exists, the web server sends it. If the server cannot find the requested page, it will send an HTTP 404 error message. (404 means 'Page Not Found' as anyone who has surfed the web probably knows.)
- The web browser receives the page back and the connection is closed.
- The browser then parses through the page and looks for other page elements it needs to complete the web page. These usually include images, applets, etc.
For each element needed, the browser makes additional connections and HTTP requests to the server for each element.
- When the browser has finished loading all images, applets, etc. the page will be completely loaded in the browser window.

HTTPS is HTTP protocol slathered with layers a SSL/TLS (encrypted layer), HTTP servers and clients speak exactly the same HTTP, but over a secure SSL connection. it is mainly 2 steps: 

1 - Hello Message : 
    ClientHello message. This contains all the information the server needs in order to connect to the client via SSL. The server responds with a ServerHello, which contains similar information required by the client
2 - Certificate Exchange: 
    Now that contact has been established, the server has to prove its identity to the client. This is achieved using its SSL certificate. 
3 - Exchange:
    The encryption of the actual message data exchanged by the client and server will be done using a symmetric algorithm using same key for encryption and decryption of data.


SSL Certificates are small data files that digitally bind a cryptographic key to an organization’s details. When installed on a web server, it activates the padlock and the https protocol and allows secure connections from a web server to a browser. 

 SSL certificate works based on public-key cryptography with two keys: 
      + private key : used to decrypt message.
      + public key : known to your server and available in the public domain. used to encrypt any message. 
      + certificates are “self-signed”, it means that digital signature is generated using the certificate’s own private key. 

 Difference between TCP and UDP :
    - TCP is connection-oriented protocol and UDP connectionless protocol , Using UDP could cause a lost of data while transferring a message.  
    - TCP messages are ordered, UDP messages my arrive in desorder.
    - TCP is a sent as a stream, we know begining and end. and UDP packets are sent individual.
    - TCP guaranteed delivery
    - UDP is commonly used for streaming audio and video
    - UDP is faster than TCP (no need for connection, no need reordring late packets, no resenting ack...)

 Domain Name System, an Internet service that provide a mapping between domain names IP addresses (both IPv4 and IPv6), text records, mail exchange information (MX records), name server information (NS records) and RR. It was used for first steps to identi
 it uses port 53. and use both UDP and TCP protocol to resolve domaine names. 

 + The DNS resolver sends a query message to the recursive resolver asking for the address of www.google.com.
 + The DNS recursor sends a query message to the root name servers looking for the .com domain name space.
 + The root name servers send a DNS referral response message to the DNS recursor informing it to ask the gTLD name servers for the .com domain name space.
 + The DNS recursor sends a query message to the gTLD name servers looking for the .cisco.com domain name space.
 + The gTLD name servers send a DNS referral response message to the DNS recursor informing it to ask the .google.com name servers, ns1.google.com or ns2.google.com, about this domain name space.
 + The DNS recursor sends a query to ns1.google.com or ns2.google.com asking for www.google.com.
 + The .google.com name servers, ns1.google.com or ns2.google.com, send an authoritative DNS query response message to the DNS recursor with the A (address) RR information for www.google.com.
 + The DNS recursor sends a DNS query response message to the DNS resolver with the A (address) RR information for www.google.com.

8 - Paste-1 

 ` paste -d';' -s test.csv `

9 - 
```

function lastLetters()
{
  echo 'fdsfds'
  size=`echo $1 | wc -c`
  echo $size
  if [ "$size" -gt "100" ]; then
    exit '101'
  fi

  if [ "$size" -lt "1" ]; then
    exit '1'
  fi
  echo $1
  res=$( echo $1 | awk '{print substr($0,length-1,2) }' | fold -w1 | tr -s '\n' ' ')
  echo $res
  return 0
}

lastLetters test
```

10 - harden a Linux server : 

- Encrypt Data Communication : Use scp, ssh, rsync, or sftp for file transfer.
- Avoid Using FTP, Telnet
- Avoid installing unnecessary software to avoid vulnerabilities in software. list all installed packages and remove useless ones / Disable Unwanted Services 
- Linux Kernel and Software Up to Date, in order to benifit from last fixes. 
- Use Linux Security Extensions :  SELinux  
- User Accounts and Strong Password Policy / SSH remote connections via OpenSsh.
- set login failure limits.
- Verify No Accounts Have Empty Passwords
- Make Sure No Non-Root Accounts Have UID Set To 0
- Disable root Login
- Find Listening Network Ports 
- Use iptables to close open ports or stop all unwanted network services 
- Separate Disk Partitions
- Logging and Auditing : Manage Logging and Auditing / Monitor Suspicious Log Messages With Logwatch 
- 

11 - multipleCopies.rb
```
[ "mutipleCopy1", "mutipleCopy2", "mutipleCopy3" ].each do |dir|
  
  directory '/var/save/#{dir}' do
   recursive true
   action :delete
   ignore_failure true
  end
  directory "/var/save/#{dir}"  do
   user 'ubuntu'
   group 'root'
   mode '0644'
   recursive true
   action :create
  end
  file '/var/save/#{dir}/secret.txt' do
   content ''
   owner 'user'
   group 'root'
   mode '0644'
   action :create
  end
end

```

12 -  creatingFiles.rb 
```
directory "/var/save/creatingFiles"  do
   user 'ubuntu'
   group 'root'
   mode '0644'
   recursive true
   action :create
  end

25.times do |i|  
   file "/var/save/creatingFiles/file_#{i}" do
   content "/var/save/creatingFiles/file_#{i} ."
   owner 'root,'
   group 'root'
   mode '0644'
   action :create
  end
end

```

13 -  forward proxy vs reverse proxy : 
- A forward proxy provides proxy services to a client or a group of clients under the local administrators, [NATing, Content filter,..] 
- A reverse proxy is a proxy configured to handle requests from a group of remote clients [NGINX, HAPROXY ] used : [ LOAD Balancers, Caching,Content Switching/Redirection ... ]
is a single entry point that serves multiple backend servers. 
e.g: receive web query, analyse it and send it to coresponds backend server [ PHP query to PHP, Fetch Javascript to Frontend Servers ] 
- A reverse proxy is more  used like application delivery controller and A forward proxy is more used like content filter. 
- reverse proxy is used to manages servers and provide high availability : [ NGINX distrubit load over 7 php servers and 7 frontends server ] 

14 - 
IPsec (Internet Protocol Security) is set of protocols for security at packet processing layer of network communication it is used for setting VPN.
Security services: 
 - Authentication Header:  allows authentication of the sender of data
 - Encapsulating Security Payload: which supports both authentication of the sender and encryption of data as well.
L2TP is a VPN without any encryption. That’s why it’s usually implemented along with IPsec encryption. L2TP/IPsec is theoretically secure. 
The traffic must be converted into L2TP form, and then encryption added on top with IPsec. It’s a two-step process.
 Yes, we can create L2TP VPN tunnel without IPsec encryption, so there is no encryption involved.
15 - OpenVPN: 
 - open-source technologies like the OpenSSL encryption library
 - easy to configure compared to L2TP/IPsec.
 - I can use on any port
 - difficult to block completely as it use same format like HTTPS.
15 - freeradius?

I didn't use freeradius before, but what I know about it is that it help to “Remote Authentication Dial In User Service” ,
 it open and scalable solution, and it can work numbrous security system in the market. Client / Server archetecture help to scale it.
