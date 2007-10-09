package org.blindsideproject.fileupload.document;

public class UnsupportedPresentationDocumentException extends BaseException {

	private static final long serialVersionUID = 610367372614072528L;

	public UnsupportedPresentationDocumentException()
	{
		super();
	}

	public UnsupportedPresentationDocumentException(String message)
	{
		super(message);
	}

	public UnsupportedPresentationDocumentException(Exception e)
	{
		super(e);
	}

	public UnsupportedPresentationDocumentException(String message, Exception e)
	{
		super(message, e);
	}
}
