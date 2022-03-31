package com.incloud.hcp.config;

import com.incloud.hcp.bean.UserSession;
import com.incloud.hcp.bean.UserSessionFront;
import com.incloud.hcp.exception.PortalException;
import com.sap.security.um.user.UnsupportedUserAttributeException;
import com.sap.security.um.user.User;
import com.sap.security.um.user.UserProvider;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import javax.naming.InitialContext;
import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;

@Component("systemLoggedUser")
public class SystemLoggedUser {

    private final Logger logger = LoggerFactory.getLogger(this.getClass());

    @Value("${sm.portal.nameId}")
    private String nameIdScp;

    @Value("${sm.portal.dev}")
    private Boolean isDev;

    @Value("${sm.portal.nameDisplay}")
    private String nameDisplay;

    @Value("${sm.portal.email}")
    private String email;

    @Value("${sm.portal.prov.idSCP}")
    private String proveedorIdSCP;

    @Value("${sm.portal.prov.ruc}")
    private String proveedorRuc;

    @Value("${sm.portal.prov.nameDisplay}")
    private String proveedorNameDisplay;

    @Value("${sm.portal.prov.email}")
    private String proveedorEmail;


    @Autowired
    public SystemLoggedUser(
    ) {

    }

    public User getUserSCP(HttpServletRequest request) {
        String keyAttribute = "com.sap.security.auth.login.User." + request.getUserPrincipal().getName().toLowerCase();
        return (User) request.getSession().getAttribute(keyAttribute);
    }

    // Temporal
    public UserSession getUserSessionProveedor() throws PortalException {

        try {


            UserSession session = new UserSession();
            //if(true) {
            session.setDisplayName(this.proveedorNameDisplay);
            session.setId(this.proveedorIdSCP);
            session.setMail(this.proveedorEmail);
            session.setRuc(this.proveedorRuc);
            return session;
            //}

        } catch (Exception ex) {
            logger.error("Error al obtener el usuario de la sesión", ex);
            throw new PortalException("Error al obtener el usuario de la sesión");
        }
    }

    public UserSession getUserSession(UserSessionFront userfront) throws PortalException {
        UserSession session = new UserSession();
        if (userfront == null) {
            session.setDisplayName(this.proveedorNameDisplay);
            session.setId(this.proveedorIdSCP);
            session.setMail(this.proveedorEmail);
            session.setRuc(this.proveedorRuc);
            return session;
        } else {
            session.setUserName(userfront.getUserName());
            session.setId(userfront.getId());
            session.setFirstName(userfront.getGivenName());
            session.setLastName(userfront.getFamilyName());
            session.setDisplayName(userfront.getDisplayName());
            session.setMail(userfront.getUserName());

            String loginName = userfront.getRuc();
            session.setRuc(loginName);

            return session;
        }
    }

    public UserSession getUserSession() throws PortalException {
        try {
            if (!isDev) {
                UserSession session = new UserSession();
                session.setDisplayName(this.nameDisplay);
                session.setId(this.nameIdScp);
                session.setMail(this.email);
                session.setRuc(this.nameIdScp);
                return session;
            }
            InitialContext ctx = new InitialContext();
            UserProvider userProvider;
            userProvider = (UserProvider) ctx.lookup("java:comp/env/user/Provider");

            User u = userProvider.getCurrentUser();
            //logger.error("Usuario u: " + u.toString());
            UserSession session = new UserSession();
            session.setUserName(u.getName());
            session.setId(this.getAttributeOfUser(u, "id"));
            session.setFirstName(this.getAttributeOfUser(u, "first_name"));
            session.setLastName(this.getAttributeOfUser(u, "last_name"));
            session.setDisplayName(this.getAttributeOfUser(u, "display_name"));
            session.setMail(this.getAttributeOfUser(u, "mail"));

            String loginName = this.getAttributeOfUser(u, "login_name");
            session.setRuc(loginName);


//            if (loginName != null && !this.stringIsLong(loginName)) // loginName no es null ni es un RUC
//                session.setSapUsername(loginName.toUpperCase());

            session.setGroupList(new ArrayList<>(u.getGroups()));
            session.setRoleList(new ArrayList<>(u.getRoles()));
            //logger.error("Usuario session: " + session.toString());

//            if (loginName != null)
//                this.guardarEditar(session);

            return session;
        } catch (Exception ex) {
            logger.error("Error al obtener el usuario de la sesión", ex);
            throw new PortalException("Error al obtener el usuario de la sesión");
        }
    }

    private boolean stringIsLong(String str) {
        try {
            Long.parseLong(str);
            return true;
        } catch (NumberFormatException ex) {
            return false;
        }
    }


    private String getAttributeOfUser(User user, String key) {
        try {
            if (user == null) {
                return null;
            }
            //logger.error("Usuario getAttributeOfUser: " + user.toString());
            //logger.error("Usuario getAttributeOfUser key: " + key);
            String atributo = user.getAttribute(key);
            //logger.error("Usuario getAttributeOfUser atributo: " + atributo);
            return atributo;
        } catch (UnsupportedUserAttributeException ex) {
            logger.error("Error al leer el atributo " + key + " de la sesión", ex);
        }
        return null;
    }
}
