using projekatFlutter.Models;

namespace projekatFlutter.Repositories
{
    public interface IRepository<T,Tkey> where T:class,IEntity<Tkey>
    {
        Task<IEnumerable<T>> GetAllAsync(); //IEnumerable ensures that i can use foreach loop to iterate through the collection of entities
        Task<T?> GetByIdAsync(Tkey id);
        Task<T> CreateAsync(T entity);
        Task<T> UpdateAsync(T entity);
        Task DeleteAsync(Tkey id);
        Task<bool> ExistsAsync(Tkey id);

    }
}
