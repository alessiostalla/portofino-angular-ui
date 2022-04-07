/*
 * Copyright (C) 2005-2020 ManyDesigns srl.  All rights reserved.
 * http://www.manydesigns.com/
 *
 * This is free software; you can redistribute it and/or modify it
 * under the terms of the GNU Lesser General Public License as
 * published by the Free Software Foundation; either version 3 of
 * the License, or (at your option) any later version.
 *
 * This software is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this software; if not, write to the Free
 * Software Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
 * 02110-1301 USA, or see the FSF site: http://www.fsf.org.
 */

package com.manydesigns.portofino.persistence.hibernate;

import org.apache.commons.lang.ObjectUtils;
import org.hibernate.HibernateException;
import org.hibernate.engine.spi.SessionImplementor;
import org.hibernate.engine.spi.SharedSessionContractImplementor;
import org.hibernate.usertype.EnhancedUserType;
import org.hibernate.usertype.ParameterizedType;

import java.io.Serializable;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.Objects;
import java.util.Properties;

/**
 * @author Paolo Predonzani     - paolo.predonzani@manydesigns.com
 * @author Angelo Lupo          - angelo.lupo@manydesigns.com
 * @author Giampiero Granatella - giampiero.granatella@manydesigns.com
 * @author Alessio Stalla       - alessio.stalla@manydesigns.com
 */
public class StringBooleanType implements EnhancedUserType, ParameterizedType {
    public static final String copyright =
            "Copyright (C) 2005-2020 ManyDesigns srl";

    // StringBuilder is to avoid interning the string
    public static final String NULL = new StringBuilder("null").toString();

    private String trueString = "T";
    private String falseString = "F";

    public int[] sqlTypes() {
        return new int[] { Types.CHAR, Types.VARCHAR };
    }

    @Override
    public int getSqlType() {
        return 0;
    }

    public Class returnedClass() {
        return Boolean.class;
    }

    public boolean equals(Object x, Object y) throws HibernateException {
        return ObjectUtils.equals(x, y);
    }

    public int hashCode(Object x) throws HibernateException {
        return ObjectUtils.hashCode(x);
    }

    @Override
    public Object nullSafeGet(
            ResultSet resultSet, int position, SharedSessionContractImplementor session, Object owner)
            throws SQLException {
        String value = resultSet.getString(position);
        return fromStringValue(value);
    }

    @Override
    public void nullSafeSet(PreparedStatement statement, Object value, int index, SharedSessionContractImplementor session)
            throws HibernateException, SQLException {
        if (value == null) {
            if (trueString != null && falseString != null) {
                statement.setString(index, null);
            } else {
                throw new HibernateException("Null is not supported as a boolean value for this type");
            }
        } else {
            statement.setString(index, (Boolean) value ? trueString : falseString);
        }
    }

    public Object deepCopy(Object value) throws HibernateException {
        return value;
    }

    public boolean isMutable() {
        return false;
    }

    public Serializable disassemble(Object value) throws HibernateException {
        return (Serializable) value;
    }

    public Object assemble(Serializable cached, Object owner) throws HibernateException {
        return cached;
    }

    public Object replace(Object original, Object target, Object owner) throws HibernateException {
        return original;
    }

    public String getTrueString() {
        return trueString;
    }

    public String getFalseString() {
        return falseString;
    }

    public void setParameterValues(Properties parameters) {
        //Strings are compared with == and != on purpose
        String nullValue = new String();
        String newString = parameters.getProperty("true", nullValue);
        if(newString != nullValue) {
            trueString = newString != NULL ? newString : null;
        }
        newString = parameters.getProperty("false", nullValue);
        if(newString != nullValue) {
            falseString = newString != NULL ? newString : null;
        }
        if(Objects.equals(trueString, falseString)) {
            throw new IllegalArgumentException("trueString and falseString must be distinct");
        }
    }

    @Override
    public String toSqlLiteral(Object value) {
        if((Boolean) value) {
            return '\'' + trueString + '\'';
        } else {
            return '\'' + falseString + '\'';
        }
    }

    @Override
    public String toString(Object value) throws HibernateException {
        if((Boolean) value) {
            return trueString;
        } else {
            return falseString;
        }
    }

    @Override
    public Object fromStringValue(CharSequence value) throws HibernateException {
        if(value != null) {
            if(value.toString().trim().equalsIgnoreCase(trueString)) {
                return Boolean.TRUE;
            } else if(value.toString().trim().equalsIgnoreCase(falseString)) {
                return Boolean.FALSE;
            } else {
                throw new HibernateException(
                        "Invalid boolean value: " + value + "; possible values are " + trueString + ", " +
                                falseString + ", null");
            }
        } else {
            if(trueString == null) {
                return true;
            } else if(falseString == null) {
                return false;
            } else {
                return null;
            }
        }
    }
}
