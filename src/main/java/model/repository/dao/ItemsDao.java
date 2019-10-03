package model.repository.dao;


import model.handlers.exceptions.DatabaseException;
import model.repository.entities.ItemEntity;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import java.util.List;

public class ItemsDao extends BasicDao {

    public static boolean delete(int id) throws Exception {
        return BasicDao.delete(new ItemEntity(id));
    }

    public static ItemEntity insert(ItemEntity item) throws Exception {
        return (ItemEntity) BasicDao.insert(item);
    }

    public static ItemEntity update(ItemEntity item) throws Exception {
        return (ItemEntity) BasicDao.update(item);
    }

    public static List<ItemEntity> findAll() throws Exception {
        EntityManagerFactory factory = getEntityManagerFactory();
        EntityManager em = factory.createEntityManager();
        try {
            em.getTransaction().begin();
            List<ItemEntity> found = em.createNamedQuery("Item.findAll").getResultList();
            em.getTransaction().commit();
            return found;
        } catch (Exception e) {
            em.getTransaction().rollback();
            throw new DatabaseException(e);
        } finally {
            em.close();
        }
    }

    public static ItemEntity findById(int id) throws Exception {
        return (ItemEntity) BasicDao.findById(new ItemEntity(id));
    }
}
