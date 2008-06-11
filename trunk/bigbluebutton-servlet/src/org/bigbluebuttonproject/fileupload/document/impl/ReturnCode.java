package org.bigbluebuttonproject.fileupload.document.impl;

public enum ReturnCode {
	/**
	 * When making changes to this class, make sure you also change
	 * org.blindsideproject.presentation.ReturnCode
	 * in the Presentation Application in Red5.
	 *
	 */
	
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
