Use the following command to build the image

    docker build \
      -t registry.opensource.zalan.do/java:8u92-jdk-alpine \
      -t registry.opensource.zalan.do/java:openjdk-8u92-jdk-alpine \
      -t registry.opensource.zalan.do/java:openjdk-8u92-alpine

Use the following command to test the image

    docker run -ti registry.opensource.zalan.do/java:8u92-jdk-alpine /bin/sh
    cd /usr/lib/jvm/java-1.8-openjdk/jre/lib/security
    keytool --list --keystore cacerts | grep amazon
    
    # output should look like the following which shows that the AWS RDS
    # certificates are in the cacerts keystore of the JDK
    amazonrdssa-east-1ca, Jul 25, 2016, trustedCertEntry, 
    amazonrdsap-southeast-1ca, Jul 25, 2016, trustedCertEntry, 
    amazonrdseu-central-1ca, Jul 25, 2016, trustedCertEntry, 
    amazonrdseu-west-1ca, Jul 25, 2016, trustedCertEntry, 
    amazonrdsus-west-1ca, Jul 25, 2016, trustedCertEntry, 
    amazonrdsap-south-1ca, Jul 25, 2016, trustedCertEntry, 
    amazonrdsap-northeast-1ca, Jul 25, 2016, trustedCertEntry, 
    amazonrdsrootca, Jul 25, 2016, trustedCertEntry, 
    amazonrdsap-southeast-2ca, Jul 25, 2016, trustedCertEntry, 
    amazonrdsus-west-2ca, Jul 25, 2016, trustedCertEntry, 
    amazonrdsap-northeast-2ca, Jul 25, 2016, trustedCertEntry, 
    amazonrdsus-east-1ca, Jul 25, 2016, trustedCertEntry, 

    
    keytool --list --keystore cacerts | grep zalando
    
    # output should look like the following which shows that the Zalando
    # Root and Service certificates are in the cacerts keystore of the
    # JDK
    zalandotechnologyrootca, Jul 25, 2016, trustedCertEntry, 
    zalandotechnologyserviceca, Jul 25, 2016, trustedCertEntry, 
