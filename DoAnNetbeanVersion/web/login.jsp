
<!DOCTYPE html>
<html lang="EN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <title>Form login</title>
    <!-- External Font Awesome CSS (for icons) -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">

    <!-- Internal CSS for styling the form -->
    <style>
        /* Reset default browser styles */
        body, html {
            margin: 0;
            padding: 0;
            font-family: Arial, sans-serif;
        }

        /* Wrapper styles */
        #wrapper {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            background-color: #f0f0f0;
        }

        /* Form styles */
        #form-login {
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            width: 300px;
        }

        .form-heading {
            text-align: center;
            margin-bottom: 20px;
        }

        .form-group {
            position: relative;
            margin-bottom: 20px;
        }

        .form-input {
            width: calc(100% - 30px);
            padding: 10px;
            padding-left: 30px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 14px;
        }

        .form-input:focus {
            outline: none;
            border-color: #4CAF50;
            box-shadow: 0 0 8px rgba(0, 128, 0, 0.2);
        }

        .form-group i {
            position: absolute;
            top: 50%;
            left: 10px;
            transform: translateY(-50%);
            color: #888;
        }

        .form-submit {
            width: 100%;
            padding: 10px;
            background-color: #4CAF50;
            border: none;
            color: #fff;
            cursor: pointer;
            border-radius: 4px;
            font-size: 16px;
        }

        .form-submit:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
    <div id="wrapper">
        <form action="LoginServlet" method="get" id="form-login">
            <h1 class="form-heading">Login Form</h1>
            <div class="form-group">
                <i class="far fa-user"></i>
                <input type="text" name="user" class="form-input" placeholder="UserName">
            </div>
            <div class="form-group">
                <i class="fas fa-key"></i>
                <input type="password" name="pwd" class="form-input" placeholder="Password">
            </div>
            <input type="submit" value="Login" class="form-submit">
        </form>
    </div>
</body>

</html>