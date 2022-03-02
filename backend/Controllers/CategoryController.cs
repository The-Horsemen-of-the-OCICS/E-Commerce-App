using ecommerceapp.models;
using ecommerceapp.services;
using Microsoft.AspNetCore.Mvc;

namespace ecommerceapp.controllers;

[ApiController]
[Route("api/[controller]")]
[Produces("application/json")]
public class CategoryController : ControllerBase{
    private readonly CategoryService _categoryService;
    public CategoryController(CategoryService categoryService) {
        this._categoryService = categoryService;
    }


/// GET API return a list of categories
    [HttpGet]
    public async Task<List<Category>> Get() {
        return await _categoryService.GetAsync();
    } 

/// GET API return a specific category
    [HttpGet("{id}")]
    public async Task<ActionResult<Category>> Get(string Id) {
        var category = await _categoryService.GetAsync(Id);
        if (category is null) {
            return NotFound();
        }
        return category;
    }

/// POST API add a category
    [HttpPost]
    public async Task<ActionResult> Post(Category newCategory) {
        await _categoryService.CreateAsync(newCategory);
        return CreatedAtAction(nameof(Get), new {id = newCategory.Id}, newCategory);
    }

/// PUT API update a category
    [HttpPut("{id}")]
    public async Task<ActionResult> Update(string Id, Category updatedCategory) {
        bool updated = await _categoryService.UpdateAsync(Id, updatedCategory);
        if (!updated) {
            // this assumes that a failed update is always caused by the object 
            // not being found. This needs to be changed if the cause may be different
            return NotFound();
        } 
        return NoContent();
    }

/// DELETE API delete a category
    [HttpDelete("{id}")]
    public async Task<ActionResult> Delete(string Id) {
        var category = await _categoryService.GetAsync(Id);
        if (category is null) {
            return NotFound();
        }
        await _categoryService.DeleteAsync(category.Id);
        return NoContent();
    }
}