package org.elasticsearch.license;
 
import java.nio.*;
import java.util.*;
import java.security.*;
import org.elasticsearch.common.xcontent.*;
import org.apache.lucene.util.*;
import org.elasticsearch.common.io.*;
import java.io.*;
 
public class LicenseVerifier
{
    public static boolean verifyLicense(final License license, final byte[] encryptedPublicKeyData) {
        return true;
    }
 
    public static boolean verifyLicense(final License license) {
        return true;
    }
}