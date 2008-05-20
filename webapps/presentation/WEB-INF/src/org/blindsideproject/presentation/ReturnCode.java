package org.blindsideproject.presentation;

/**
 * When making changes to this class, make sure you also change
 * org.blindsideproject.fileupload.document.impl.ReturnCode
 * in the FileUpload Application.
 *
 */
public enum ReturnCode {
	FAIL (0, "FAIL <UNKNOWN>"),
	WRONG_FORMAT (1, "WRONG FORMAT"),
	OO_CONNECTION (2, "OPEN OFFICE CONNECTION"),
	FILE_NOT_FOUND (3, "FILE NOT FOUND"),
	SWFTOOLS (4, "SWFTOOLS"),
	EXTRACT (5, "EXTRACT"),
	CONVERT (6, "CONVERT"),
	UPDATE (7, "UPDATE"),
	SUCCESS (8, "SUCCESS");
	
	private final String code;
	private final int value;
	
	ReturnCode(int value, String code) {
		this.value = value;
		this.code = code;
	}
	
	public String code() {
		return code;
	}
	
	public int value() {
		return value;
	}
}
