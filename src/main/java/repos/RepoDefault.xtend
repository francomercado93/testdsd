package repos

import java.util.List
import javax.persistence.EntityManagerFactory
import javax.persistence.Persistence
import javax.persistence.PersistenceException
import javax.persistence.criteria.CriteriaBuilder
import javax.persistence.criteria.CriteriaQuery
import javax.persistence.criteria.Root

abstract class RepoDefault<T> {

	static final EntityManagerFactory entityManagerFactory = Persistence.createEntityManagerFactory("Joits")

	def List<T> allInstances() {
		val entityManager = this.entityManager
		try {
			val criteria = entityManager.criteriaBuilder
			val query = criteria.createQuery(entityType)
			val from = query.from(entityType)
			query.select(from)
			entityManager.createQuery(query).resultList
		} finally {
			entityManager?.close
		}
	}

	def create(T t) {
		val entityManager = this.entityManager
		try {
			entityManager => [
				transaction.begin
				persist(t)
				transaction.commit
			]
		} catch (PersistenceException e) {
			e.printStackTrace
			entityManager.transaction.rollback
			throw new RuntimeException("Ocurrió un error, la operación no puede completarse", e)
		} finally {
			entityManager?.close
		}
	}

	def update(T t) {
		val entityManager = this.entityManager
		try {
			entityManager => [
				transaction.begin
				merge(t)
				transaction.commit
			]
		} catch (PersistenceException e) {
			e.printStackTrace
			entityManager.transaction.rollback
			throw new RuntimeException("Ocurrió un error, la operación no puede completarse", e)
		} finally {
			entityManager?.close
		}
	}

	def getEntityManager() {
		entityManagerFactory.createEntityManager
	}

	abstract def Class<T> getEntityType()

	def List<T> searchByName(String nombre) {
		val entityManager = this.entityManager
		try {
			val criteria = entityManager.criteriaBuilder
			val query = criteria.createQuery(entityType)
			val from = query.from(entityType)
			query.select(from)
			generateWhere(criteria, query, from, nombre)
			entityManager.createQuery(query).resultList
		} finally {
			entityManager?.close
		}
	}

	abstract def void generateWhere(CriteriaBuilder criteria, CriteriaQuery<T> query, Root<T> campos, String nombre)

	abstract def T searchById(Long id)

}
