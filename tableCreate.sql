CREATE TABLE Universe (
    UniversalName VARCHAR(50),
    Age REAL,
    ExpansionaryRate REAL,
    PRIMARY KEY (UniversalName)
);

CREATE TABLE Galaxy (
    GalacticName VARCHAR(50),
    Constellation VARCHAR(50),
    VariationType VARCHAR(50),
    Radius REAL,
    StarCount INT,
    CentralObject VARCHAR(50),
    Universe VARCHAR(50) NOT NULL,
    PRIMARY KEY (GalacticName),
    FOREIGN KEY (Universe) REFERENCES Universe(UniversalName) ON DELETE CASCADE
);

CREATE TABLE PlanetarySystem (
    HostName VARCHAR(50),
    NumberOfStars INT,
    NumberOfPlanets INT,
    Radius REAL,
    Host VARCHAR(50) NOT NULL,
    Universe VARCHAR(50) NOT NULL,
    PRIMARY KEY (HostName),
    FOREIGN KEY (Host) REFERENCES Galaxy(GalacticName) ON DELETE CASCADE,
    FOREIGN KEY (Universe) REFERENCES Universe(UniversalName) ON DELETE CASCADE
);

CREATE TABLE Quasar (
    QuasarName VARCHAR(50),
    SpectralRedshift REAL,
    DistanceFromEarth REAL,
    Luminosity REAL,
    BlackHoleMass REAL,
    Universe VARCHAR(50) NOT NULL,
    PRIMARY KEY (QuasarName),
    FOREIGN KEY (Universe) REFERENCES Universe(UniversalName) ON DELETE CASCADE
);

CREATE TABLE CelestialBody (
    CelestialName VARCHAR(50),
    DiscoveryYear INT,
    ObjectType CHAR(1) NOT NULL,
    GalacticHost VARCHAR(50) NOT NULL,
    PRIMARY KEY (CelestialName, ObjectType),
    FOREIGN KEY (GalacticHost) REFERENCES PlanetarySystem(HostName) ON DELETE CASCADE,
    CHECK (ObjectType IN ('S', 'P')) -- validates object type
);

CREATE TABLE Star (
    SolarName VARCHAR(50),
    ObjectType CHAR(1),
    SpectralType CHAR(10),
    Radius REAL,
    ElementalComposition VARCHAR(50),
    PRIMARY KEY (SolarName),
    FOREIGN KEY (SolarName, ObjectType) REFERENCES CelestialBody(CelestialName, ObjectType) ON DELETE CASCADE,
    CHECK (ObjectType = 'S')
);

CREATE TABLE Exoplanet (
    PlanetaryName VARCHAR(50),
    ObjectType CHAR(1),
    Radius REAL,
    DurationOfDay REAL,
    OrbitalPeriod REAL,
    PlanetaryType VARCHAR(50),
    GravityStrength VARCHAR(50),
    Biosphere INT,
    SolarHost VARCHAR(50) NOT NULL,
    PRIMARY KEY (PlanetaryName),
    FOREIGN KEY (SolarHost) REFERENCES Star(SolarName) ON DELETE CASCADE,
    FOREIGN KEY (PlanetaryName, ObjectType) REFERENCES CelestialBody(CelestialName, ObjectType) ON DELETE CASCADE
);


CREATE TABLE Moon (
    LunarName VARCHAR(50),
    Radius REAL,
    TidalLock INT,
    CoreComposition VARCHAR(50),
    OrbitalPeriod REAL,
    DiscoveryYear INT,
    Host VARCHAR(50) NOT NULL,
    PRIMARY KEY (LunarName, Host),
    FOREIGN KEY (Host) REFERENCES Exoplanet(PlanetaryName) ON DELETE CASCADE
);


CREATE TABLE Biome (
    BiomeType VARCHAR(50),
    AverageTemperature REAL,
    EcologicalComposition VARCHAR(50),
    PRIMARY KEY (BiomeType)
);

CREATE TABLE Ecosystem (
    Planet VARCHAR(50),
    Biome VARCHAR(50),
    PRIMARY KEY (Planet, Biome),
    FOREIGN KEY (Planet) REFERENCES Exoplanet(PlanetaryName) ON DELETE CASCADE,
    FOREIGN KEY (Biome) REFERENCES Biome(BiomeType) ON DELETE CASCADE
);

CREATE TABLE Kingdom (
    Taxonomy VARCHAR(50),
    ColloquialGenus VARCHAR(50),
    TrophicLevel VARCHAR(50),
    SpeciesCount INT,
    ReproductionType VARCHAR(50),
    Lifespan INT,
    PRIMARY KEY (Taxonomy)
);

CREATE TABLE Has_Kingdom(
    Taxonomy VARCHAR(50),
    Planet VARCHAR(50),
    Biome VARCHAR(50),
    Alleles INT,
    PRIMARY KEY (Taxonomy, Planet, Biome),
    FOREIGN KEY (Taxonomy) REFERENCES Kingdom(Taxonomy) ON DELETE CASCADE,
    FOREIGN KEY (Planet, Biome) REFERENCES Ecosystem(Planet, Biome) ON DELETE CASCADE
);