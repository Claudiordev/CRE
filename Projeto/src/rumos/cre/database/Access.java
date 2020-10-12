package rumos.cre.database;

import javax.annotation.PreDestroy;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

public class Access {
	
	static EntityManagerFactory emf;
	static EntityManager em;
	
	//Database Acces Construct, if already existent destroy and create new one
	public Access() {
		destruct();
		
		emf = Persistence.createEntityManagerFactory("CREUnit");
		em = emf.createEntityManager();
		
	}
	
	/**
	 * Delete existent emf EntityManagerFactory Object
	 */
	@PreDestroy
	public void destruct() {
		if (emf != null) {
			emf.close();
		}
	}

	/**
	 * @return EntityManager to access Database, such as Queries or Entities
	 */
	public EntityManager getEm() {
		return em;
	}

}
