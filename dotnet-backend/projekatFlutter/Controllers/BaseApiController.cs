using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Http.HttpResults;
using Microsoft.AspNetCore.Mvc;
using projekatFlutter.Data;
using projekatFlutter.Models;
using projekatFlutter.Repositories;

namespace projekatFlutter.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class BaseApiController<T,Tkey> : ControllerBase
        where T:class,IEntity<Tkey>
    {
        protected readonly IRepository<T, Tkey> _repository;
        public BaseApiController(IRepository<T,Tkey> repository)
        {
            _repository = repository;
        }
        [HttpGet]
        public virtual async Task<ActionResult<IEnumerable<T>>> GetAll()
        {
            var entities = await _repository.GetAllAsync();
            return Ok(entities);
        }
        [HttpGet("{id}")]
        public virtual async Task<ActionResult<T>> GetById(Tkey id)
        {
            var entity= await _repository.GetByIdAsync(id);
            if(entity == null)
            {
                return NotFound();
            }
            return Ok(entity);
        }
        [HttpPost]
        public virtual async Task<ActionResult<T>> Create(T entity)
        {
            var created=await _repository.CreateAsync(entity);
            return CreatedAtAction(nameof(GetById), new { id = created.Id }, created);
        }
        [HttpPut("{id}")]
        public virtual async Task<ActionResult<T>> Update(Tkey id,T entity)
        {
            if(!id.Equals(entity.Id))
            {
                return BadRequest(new { message = "ID mismatch" });
            }
            if(!await _repository.ExistsAsync(id))
            {
                return NotFound();
            }
            await _repository.UpdateAsync(entity);
            return NoContent();
        }
        [HttpDelete("{id}")]
        public virtual async Task<IActionResult> Delete(Tkey id)
        {
            if (!await _repository.ExistsAsync(id)) 
            {
                return NotFound(new {message= "Entity not found" });
            }
            await _repository.DeleteAsync(id);
            return NoContent();
        }
    }
}
