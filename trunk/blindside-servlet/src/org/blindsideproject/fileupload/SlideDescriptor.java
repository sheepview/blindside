package org.blindsideproject.fileupload;

import org.springframework.util.Assert;

/**
 * Entity class used to create instances that describes slide: name and conference room ID
 * @author ritzalam 
 *
 */
public class SlideDescriptor {

	// name of the slide
	private final String name;
	// conference room ID
	private final Integer room;

	public SlideDescriptor(String name, Integer room) {
		Assert.notNull(name, "No image name specified");
		this.name = name;
		this.room = room;
	}
	/**
	 * getter for slide name
	 * 
	 * @return name of the slide
	 */
	public String getName() {
		return name;
	}
	/**
	 * getter for conference rooom ID
	 * @return conference room ID
	 */
	public Integer getRoom() {
		return room;
	}
}
