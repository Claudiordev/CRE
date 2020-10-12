package rumos.cre.entities;

import java.io.Serializable;
import javax.persistence.*;
import java.math.BigDecimal;


/**
 * The entity class for the faturas database table.
 * UNUSED on the project;
 */
@Entity
@Table(name="faturas")
@NamedQuery(name="Fatura.findAll", query="SELECT f FROM Fatura f")
public class Fatura implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private int id;

	private int iva;

	private String nif;

	private BigDecimal precototal;

	private String produtos;

	private int pvp;

	public Fatura() {
	}

	public int getId() {
		return this.id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getIva() {
		return this.iva;
	}

	public void setIva(int iva) {
		this.iva = iva;
	}

	public String getNif() {
		return this.nif;
	}

	public void setNif(String nif) {
		this.nif = nif;
	}

	public BigDecimal getPrecototal() {
		return this.precototal;
	}

	public void setPrecototal(BigDecimal precototal) {
		this.precototal = precototal;
	}

	public String getProdutos() {
		return this.produtos;
	}

	public void setProdutos(String produtos) {
		this.produtos = produtos;
	}

	public int getPvp() {
		return this.pvp;
	}

	public void setPvp(int pvp) {
		this.pvp = pvp;
	}

}