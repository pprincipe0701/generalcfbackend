package com.incloud.hcp.job;


import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

@Component
public class ScheduledTasks {

    private static final org.slf4j.Logger logger = org.slf4j.LoggerFactory.getLogger(ScheduledTasks.class);

    private static final DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern("HH:mm:ss");



    /*@Autowired
    private AppProcesoLogRepository appProcesoLogRepository;*/









    @Scheduled(cron = "0 5,35 * * * ?")
    public void scheduleEnviarCorreoRecordatorio() {
        logger.error("Cron Task scheduleEnviarCorreoRecordatorio :: Execution Time - {}", dateTimeFormatter.format(LocalDateTime.now()));

    }

    @Scheduled(cron = "0 30 5-23 * * ?")
    public void scheduleActualizarTasaCambio() {
        logger.error("Cron Task scheduleActualizarTasaCambio :: Execution Time - {}", dateTimeFormatter.format(LocalDateTime.now()));

    }



}