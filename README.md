# UNDERTOW-1521 test case (based on ssltest)

There are two .java source files which contain everything. You can use Apache `ant` or the `build.sh` script to compile the .java source and bundle it into an executable JAR file, which an be run like this:


```
$ java -jar ssltest.jar -connectonly TARGET_UNDERTOW_SERVER_NAME_OR_IP [TARGET_PORT]
```

The hostname of the target server is required, and the default port is 443 (HTTPS).

