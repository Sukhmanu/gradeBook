package com.moodle.gradebook.util;

import javax.servlet.http.HttpServletRequest;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

/**
 * Param is simple util class for HttpServletRequest, having commonly used static methods used to perform simple type
 * conversion of the String type parameters of HttpServletRequest.
 */
public class Param {
    HttpServletRequest request = null;

    public Param(HttpServletRequest request){
        this.request = request;
    }

    /* getInt method performs Integer type conversion of String type parameter of HttpServletRequest.
      it returns integer value for a given parameters */
    public int getInt(String ParameterName){
        int id = 0;
        try{
            id = Integer.valueOf(request.getParameter(ParameterName));
        } catch (NumberFormatException e){
            e.printStackTrace();
        }
        return id;
    }

    /* getIntegers method will returns the list of Integer for a given ParameterValues in a HTTP request */
    public List<Integer> getIntegers(String ParameterName){
        String[] StringValues = request.getParameterValues(ParameterName);
        return ListUtil.transform(StringValues, Integer::parseInt);
    }

    /* getLong method will returns a long for a given Parameter in a HTTP request */
    public long getLong(String ParameterName){
        long id = 0;
        try{
            id = Long.valueOf(request.getParameter(ParameterName));
        } catch (NumberFormatException e){
            e.printStackTrace();
        }
        return id;
    }

    /* getLong method will returns a float for a given Parameter in a HTTP request */
    public float getFloat(String ParameterName){
        float id = 0;
        try{
            id = Float.valueOf(request.getParameter(ParameterName));
        } catch (NumberFormatException e){
            e.printStackTrace();
        }
        return id;
    }

    /* getFloats method will returns a List of Floats for a given ParameterValues in a HTTP request */
    public List<Float> getFloats(String ParameterName){
        String[] StringValues = request.getParameterValues(ParameterName);
        return ListUtil.transform(StringValues, Float::parseFloat);
    }

    /* getDate method will will parse the data value from HTTP request parameter of type String and
    * converts its to a java.util.Date type  */
    public Date getDate(String ParameterName){
        String dateStr = request.getParameter(ParameterName);
        SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy");
        Date date = null;
        try {
            date = sdf.parse(dateStr);
        } catch (ParseException e) {
            e.printStackTrace();
        }
        return date;
    }

    // this method simply returns the value of HTTP request parameter
    public String getString(String ParameterName){
        return request.getParameter(ParameterName);
    }
}
