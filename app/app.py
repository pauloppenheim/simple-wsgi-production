
import wsgiref.simple_server
import datetime

def application(environ, start_response):
    start_response("200 OK",[("Content-Type", "text/html")])
    res = """
<html>
<head>
    <title>simplewsgipro app</title>
    <link rel="stylesheet" href="/style.css" type="text/css" />
</head>
<body>
<h1>HELLO.</h1>
<p>THE UTC TIME IS CURRENTLY: %s</p>
<p><a href="../">&#x2190; BACK</a></p>
</body>
</html>
    """ % (str(datetime.datetime.utcnow().isoformat()))
    return [res]

def main():
    httpd = wsgiref.simple_server.make_server('', 8000, application)
    print "Serving on port 8000..."
    # Serve until process is killed
    httpd.serve_forever()

if "__main__" == __name__:
    main()
