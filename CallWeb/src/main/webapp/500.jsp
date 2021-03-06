<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page isErrorPage="true" %>  

 <section class="content-header">
      <h1>
        500 Error Page
      </h1>
      
    </section>

    <!-- Main content -->
    <section class="content">

      <div class="error-page">
        <h2 class="headline text-red">500</h2>

        <div class="error-content">
          <h3><i class="fa fa-warning text-red"></i> Oops! Something went wrong.</h3>

          <p>
            We will work on fixing that right away.
            Meanwhile, you may <a href="index.jsp">return to dashboard</a> or try using the search form.
          </p>
Exception is: <%= exception %>  

        
        </div>
      </div>
      <!-- /.error-page -->

    </section>
    <!-- /.content -->

