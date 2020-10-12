package rumos.cre.entities;

import java.io.Serializable;
import javax.persistence.*;
import java.util.List;


/**
 * The entity class for the roles database table.
 * 
 */
@Entity
@Table(name="roles")
@NamedQuery(name="Role.findAll", query="SELECT r FROM Role r")
public class Role implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="role_id")
	private int roleId;

	private String nome;

	//bi-directional many-to-one association to Empregado
	@OneToMany(mappedBy="role")
	private List<Empregado> empregados;

	public Role() {
	}

	public int getRoleId() {
		return this.roleId;
	}

	public void setRoleId(int roleId) {
		this.roleId = roleId;
	}

	public String getNome() {
		return this.nome;
	}

	public void setNome(String nome) {
		this.nome = nome;
	}

	public List<Empregado> getEmpregados() {
		return this.empregados;
	}

	public void setEmpregados(List<Empregado> empregados) {
		this.empregados = empregados;
	}

	public Empregado addEmpregado(Empregado empregado) {
		getEmpregados().add(empregado);
		empregado.setRole(this);

		return empregado;
	}

	public Empregado removeEmpregado(Empregado empregado) {
		getEmpregados().remove(empregado);
		empregado.setRole(null);

		return empregado;
	}

}