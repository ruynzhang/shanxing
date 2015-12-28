package com.dimeng.p2p.console.servlets;

import java.security.SecureRandom;

public class Test {
	protected static final SecureRandom RANDOM = new SecureRandom();
	public static void main(String[] args) {
		System.out.println('_' + Long.toHexString(RANDOM.nextLong()));
	}

}
