package com.moodle.gradebook.util;

import java.util.Date;

public class DateConverter {
	
	public static java.sql.Date convert(Date date) {
	    if(date == null)
	        return null;
		return new java.sql.Date(date.getTime());
	}

}
