package com.incloud.hcp.config;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Optional;

public class ToDate {
/*
    public static Date getDevuelveFechaHora(String pfecha, String phora) {
        if (StringUtils.isBlank(pfecha)) {
            return null;
        }
        Date dFecha = getDateFromString(pfecha).orElse(null);
        if (StringUtils.isNotBlank(phora)) {
            String fechaHora = pfecha + " " + phora;
            dFecha = getDateFromString(fechaHora, DATE_TIME_FORMAT_RESOURCES).orElse(null);
        }
        return dFecha;
    }*/

    public static Optional<Date> getDateFromString(String date, String format) {
        try {
            DateFormat df = new SimpleDateFormat(format);
            Date d = df.parse(date);
            return Optional.of(d);
        } catch (ParseException ex) {
            return Optional.empty();
        }
    }


}
