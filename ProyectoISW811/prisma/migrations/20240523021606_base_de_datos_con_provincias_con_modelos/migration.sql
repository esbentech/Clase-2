-- CreateTable
CREATE TABLE `Solicitantes` (
    `SolicitantesId` INTEGER NOT NULL AUTO_INCREMENT,
    `NombreDelSolicitante` VARCHAR(191) NOT NULL,
    `ApellidoDelSolicitante` VARCHAR(191) NOT NULL,
    `CorreoDelSolicitante` VARCHAR(191) NOT NULL,
    `TelefonoDelSolicitante` VARCHAR(191) NOT NULL,

    UNIQUE INDEX `Solicitantes_CorreoDelSolicitante_key`(`CorreoDelSolicitante`),
    PRIMARY KEY (`SolicitantesId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Solicitudes` (
    `Solicitudesid` INTEGER NOT NULL AUTO_INCREMENT,
    `FechaSolicitud` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `SolicitanteId` INTEGER NOT NULL,
    `ServiciosId` INTEGER NOT NULL,
    `EstadoDeSolicitud` ENUM('Pendiente', 'Aprobada', 'Denegada') NOT NULL DEFAULT 'Pendiente',

    PRIMARY KEY (`Solicitudesid`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Servicios` (
    `ServiciosId` INTEGER NOT NULL AUTO_INCREMENT,
    `Servicio` VARCHAR(191) NOT NULL,
    `Descripcion` VARCHAR(191) NOT NULL,

    PRIMARY KEY (`ServiciosId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Programaciones` (
    `ProgramacionesId` INTEGER NOT NULL AUTO_INCREMENT,
    `FechaDeProgramacion` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `ServiciosId` INTEGER NOT NULL,
    `EstadoProgramacion` VARCHAR(191) NOT NULL,
    `SolicitantesId` INTEGER NOT NULL,

    PRIMARY KEY (`ProgramacionesId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Auditorias` (
    `AuditoriasId` INTEGER NOT NULL AUTO_INCREMENT,

    PRIMARY KEY (`AuditoriasId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Usuarios` (
    `UsuarioId` INTEGER NOT NULL AUTO_INCREMENT,
    `NombreDeUsuario` VARCHAR(191) NOT NULL,
    `CorreoDelUsuario` VARCHAR(191) NOT NULL,
    `ContrasennaDelusuario` VARCHAR(191) NOT NULL,
    `EstadoDeUsuario` ENUM('Activo', 'Desactivado') NOT NULL DEFAULT 'Activo',
    `AuditoriasId` INTEGER NOT NULL,

    PRIMARY KEY (`UsuarioId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Provincias` (
    `ProvinciaId` INTEGER NOT NULL AUTO_INCREMENT,
    `Provincia` VARCHAR(191) NOT NULL,
    `FechaDeCreacion` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `ActualizadoEn` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    PRIMARY KEY (`ProvinciaId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Cantones` (
    `CantonId` INTEGER NOT NULL AUTO_INCREMENT,
    `Canton` VARCHAR(191) NOT NULL,
    `ProvinciaId` INTEGER NOT NULL,
    `FechaDeCreacion` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `ActualizadoEn` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    PRIMARY KEY (`CantonId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Distritos` (
    `DistritoId` INTEGER NOT NULL AUTO_INCREMENT,
    `Distrito` VARCHAR(191) NOT NULL,
    `CantonId` INTEGER NOT NULL,
    `FechaDeCreacion` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `ActualizadoEn` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `Valoracion` ENUM('Excelente', 'Bueno', 'Regular') NOT NULL DEFAULT 'Bueno',

    PRIMARY KEY (`DistritoId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `Solicitudes` ADD CONSTRAINT `Solicitudes_SolicitanteId_fkey` FOREIGN KEY (`SolicitanteId`) REFERENCES `Solicitantes`(`SolicitantesId`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Solicitudes` ADD CONSTRAINT `Solicitudes_ServiciosId_fkey` FOREIGN KEY (`ServiciosId`) REFERENCES `Servicios`(`ServiciosId`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Programaciones` ADD CONSTRAINT `Programaciones_ServiciosId_fkey` FOREIGN KEY (`ServiciosId`) REFERENCES `Servicios`(`ServiciosId`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Programaciones` ADD CONSTRAINT `Programaciones_SolicitantesId_fkey` FOREIGN KEY (`SolicitantesId`) REFERENCES `Solicitantes`(`SolicitantesId`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Usuarios` ADD CONSTRAINT `Usuarios_AuditoriasId_fkey` FOREIGN KEY (`AuditoriasId`) REFERENCES `Auditorias`(`AuditoriasId`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Cantones` ADD CONSTRAINT `Cantones_ProvinciaId_fkey` FOREIGN KEY (`ProvinciaId`) REFERENCES `Provincias`(`ProvinciaId`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Distritos` ADD CONSTRAINT `Distritos_CantonId_fkey` FOREIGN KEY (`CantonId`) REFERENCES `Cantones`(`CantonId`) ON DELETE RESTRICT ON UPDATE CASCADE;
