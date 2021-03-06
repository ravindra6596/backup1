<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
	<title>Dial Pad</title>
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<!-- jQuery library -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<!-- Latest compiled JavaScript -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="css/style.css">
</head>
<body>
<div class="container">
    <div class="row">
    <div class="col-md-9"></div>
        <div class="col-md-3  phone">
            <div class="row1">
                <div class="col-md-12">
                <form action="MakeCall" method="POST">
                <h3 style="text-align: center;">RDIGS Dial Pad</h3>
                <input type="tel" name="dialNo" id="telNumber" class="form-control tel" value="+918698965948" />
                    <div class="num-pad">
                    <div class="span4">
                        <div class="num">
                            <div class="txt abc">1</div>
                        </div>
                    </div>
                    <div class="span4">
                        <div class="num">
                            <div class="txt abc">2</div>
                        </div>
                    </div>
                    <div class="span4">
                        <div class="num">
                            <div class="txt abc">3</div>
                        </div>
                    </div>
                    <div class="span4">
                        <div class="num">
                            <div class="txt abc">4</div>
                        </div>
                    </div>
                    <div class="span4">
                        <div class="num">
                            <div class="txt abc">5</div>
                        </div>
                    </div>
                    <div class="span4">
                        <div class="num">
                            <div class="txt abc">6</div>
                        </div>
                    </div>
                    <div class="span4">
                        <div class="num">
                            <div class="txt abc">7</div>
                        </div>
                    </div>
                    <div class="span4">
                        <div class="num">
                            <div class="txt abc">8</div>
                        </div>
                    </div>
                    <div class="span4">
                        <div class="num">
                            <div class="txt abc">9</div>
                        </div>
                    </div>
                    <div class="span4">
                        <div class="num">
                            <div class="txt abc">
                                *
                            </div>
                        </div>
                    </div>
                    <div class="span4">
                        <div class="num">
                            <div class="txt abc">0</div>
                        </div>
                    </div>
                    <div class="span4">
                        <div class="num">
                            <div class="txt abc">#</div>
                        </div>
                    </div>
                    </div>
                    <div class="clearfix">
                    </div>
                    <button type="submit" class="btn btn-success btn-block flatbtn" name="submit" value="submit">CALL</button>
                        <a href="#" class="btn btn-danger btn-block flatbtn">DISCONNECT</a><br>
                </form> </div>
               
            </div>
            <div class="clearfix">
            </div>
            <div class="clearfix">
            </div>
        </div>
    </div>
</div>
<script src="js/script.js"></script>
</body>
</html>