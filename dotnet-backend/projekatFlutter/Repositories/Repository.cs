using Microsoft.EntityFrameworkCore;
using projekatFlutter.Data;

namespace projekatFlutter.Repositories
{
    public class Repository<T, Tkey> : IRepository<T, Tkey>
    where T : class, Models.IEntity<Tkey>
    {
        protected readonly ApiDbContext _context;
        protected readonly DbSet<T> _dbset; //entry point for performing CRUD operations on the database
        public Repository(ApiDbContext context)
        {
            _context = context;
            _dbset = _context.Set<T>();//ensures that i use correct DbSet no matter whitch entity type is used
        }
        public virtual async Task<IEnumerable<T>> GetAllAsync()
        {
            return await _dbset.ToListAsync();//this is as i did SELECT * FROM Table
        }
        public virtual async Task<T?> GetByIdAsync(Tkey id)
        {
            return await _dbset.FindAsync(id);
        }
        public virtual async Task<T> CreateAsync(T entity)
        {
            await _dbset.AddAsync(entity);
            await _context.SaveChangesAsync();
            return entity;
        }
        public virtual async Task<T> UpdateAsync(T entity)
        {
            _dbset.Update(entity);
            await _context.SaveChangesAsync();
            return entity;
        }
        public virtual async Task DeleteAsync(Tkey id)
        {
            var entity = await _dbset.FindAsync(id);
            if (entity != null)
            {
                _dbset.Remove(entity);
                await _context.SaveChangesAsync();
            }
        }
        public virtual async Task<bool> ExistsAsync(Tkey id)
        {
            return await _dbset.AnyAsync(e => e.Id.Equals(id));

        }
    }
}
