package com.moodle.gradebook.util;

import java.util.Collection;

public class TagUtil {
    public static boolean contains(Collection<?> coll, Object o) {
        if (coll == null) return false;
        return coll.contains(o);
    }
}
