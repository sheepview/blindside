package org.bigbluebuttonproject.fileupload.document;
/**
 * Exception class used in servlet classes
 * 
 * @author ritzalam  
 *
 */

public class BaseException extends java.lang.Exception
{
	private static final long serialVersionUID = 3608396488252900444L;
	
	private String message = "";
	private Exception exception = null;

	public BaseException()
	{
		super();
	}

	public BaseException(String message)
	{
		super();
		this.message = message;
	    this.exception = null;
	}

	public BaseException(Exception e)
	{
		super();
		this.message = this.getClass().getName();
		this.exception = e;
	}

	public BaseException(String message, Exception e)
	{
		super();
		this.message = message;
		this.exception = e;
	}

	public String getMessage()
	{
		if ( ( (message == null) || (message.length() == 0)) && exception != null)
		{
			return exception.getMessage();
		}
		else
		{
			return this.message;
		}
	}

	public Exception getException()
	{
		return exception;
	}

	public String toString()
	{
		return getMessage();
	}

	public void printStackTrace()
	{
		super.printStackTrace();
		if (exception != null)
		{
			System.err.println();
			System.err.println("Embedded exception:");
			exception.printStackTrace();
		}
	}

	public void printStackTrace(java.io.PrintStream s)
	{
		super.printStackTrace(s);
		if (exception != null)
		{
			s.println();
			s.println("Embedded exception:");
			exception.printStackTrace(s);
		}
	}

	public void printStackTrace(java.io.PrintWriter s)
	{
		super.printStackTrace(s);
		if (exception != null)
		{
			s.println();
			s.println("Embedded exception:");
			exception.printStackTrace(s);
		}
	}
}
