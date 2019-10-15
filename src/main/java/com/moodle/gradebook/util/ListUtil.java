package com.moodle.gradebook.util;

import java.util.Arrays;
import java.util.Collections;
import java.util.List;
import java.util.function.Function;
import java.util.stream.Collectors;

/**
 * ListUtil class is a simple util class having one static method used to perform type conversion on arrays
 * and returns a list of elements with converted values
 * copied from https://www.techiedelight.com/convert-list-string-list-integer-java/
 * */
public class ListUtil {
    public static <T, U> List<U> transform(T[] arry, Function<T, U> function) {
        //if an given array is empty then return a empty list
        if(arry == null)
            return Collections.emptyList();

        //create a List out of an array values
        List<T> list = Arrays.asList(arry);
        //create a stream out of an list to perform the type conversion
        return list.stream()
                //stream map function will do the type conversion of each element in a stream based of the provided function
                .map(function)
                // stream collect function will collects all the converted elements from map function and build new elements list
                .collect(Collectors.toList());
    }
}
