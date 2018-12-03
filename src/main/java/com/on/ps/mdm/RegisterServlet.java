package com.on.ps.mdm;

import com.orchestranetworks.module.ModuleContextOnRepositoryStartup;
import com.orchestranetworks.module.ModuleRegistrationServlet;
import com.orchestranetworks.service.OperationException;
import com.orchestranetworks.ps.module.PSRegisterServlet;

//public class RegisterServlet extends ModuleRegistrationServlet {
public class RegisterServlet extends PSRegisterServlet {

	/**
	 *
	 */
	private static final long serialVersionUID = 1L;

	public RegisterServlet() { super("xyz-mdm"); }
	//@Override public void handleRepositoryStartup(ModuleContextOnRepositoryStartup arg0) throws OperationException {}

}
