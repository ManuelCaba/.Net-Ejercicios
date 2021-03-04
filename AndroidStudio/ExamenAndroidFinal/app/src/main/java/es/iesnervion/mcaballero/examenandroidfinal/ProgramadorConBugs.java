package es.iesnervion.mcaballero.examenandroidfinal;

import androidx.room.Embedded;
import androidx.room.Relation;

import java.util.List;

public class ProgramadorConBugs {

    @Embedded
    private Programador programador;

    @Relation(
            parentColumn = "DNI",
            entityColumn = "IDProgramador"
    )
    private List<Bug> bugs;

    public Programador getProgramador() {
        return programador;
    }

    public List<Bug> getBugs() {
        return bugs;
    }

    public void setProgramador(Programador programador) {
        this.programador = programador;
    }

    public void setBugs(List<Bug> bugs) {
        this.bugs = bugs;
    }
}
