package com.incloud.hcp.bean;

public class UserSessionFront {

    private String displayName;         // EJM: jorodriguez
    private String userName;            // correo
    private String givenName;           // firstName
    private String familyName;          // lastName
    private String company;             // Por defecto trae solo el valor "company"
    private String id;                  // EJM: P000004, P000005, P000006
    private String userType;            // EJM: Employee
    private String ruc;                 // Codigo proveedor

    public String getDisplayName() {
        return displayName;
    }

    public void setDisplayName(String displayName) {
        this.displayName = displayName;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getGivenName() {
        return givenName;
    }

    public void setGivenName(String givenName) {
        this.givenName = givenName;
    }

    public String getFamilyName() {
        return familyName;
    }

    public void setFamilyName(String familyName) {
        this.familyName = familyName;
    }

    public String getCompany() {
        return company;
    }

    public void setCompany(String company) {
        this.company = company;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getUserType() {
        return userType;
    }

    public void setUserType(String userType) {
        this.userType = userType;
    }

    public String getRuc() {
        return ruc;
    }

    public void setRuc(String ruc) {
        this.ruc = ruc;
    }

    @Override
    public String toString() {
        return "UserSessionFront{" +
                "displayName='" + displayName + '\'' +
                ", userName='" + userName + '\'' +
                ", givenName='" + givenName + '\'' +
                ", familyName='" + familyName + '\'' +
                ", company='" + company + '\'' +
                ", id='" + id + '\'' +
                ", userType='" + userType + '\'' +
                ", ruc='" + ruc + '\'' +
                '}';
    }
}
