package org.blindsideproject.fileupload;

import org.springframework.util.Assert;

public class SlideDescriptor {

	private final String name;

	private final Integer room;

	public SlideDescriptor(String name, Integer room) {
		Assert.notNull(name, "No image name specified");
		this.name = name;
		this.room = room;
	}

	public String getName() {
		return name;
	}

	public Integer getRoom() {
		return room;
	}
}
