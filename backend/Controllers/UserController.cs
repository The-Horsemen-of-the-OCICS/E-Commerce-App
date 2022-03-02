using ecommerceapp.models;
using ecommerceapp.services;
using Microsoft.AspNetCore.Mvc;

namespace ecommerceapp.controllers;

[ApiController]
[Route("api/[controller]")]
[Produces("application/json")]
public class UserController : ControllerBase{
    private readonly UserService _userService;
    public UserController(UserService userService) {
        this._userService = userService;
    }

/// GET API return a list of users
    [HttpGet]
    public async Task<List<User>> Get() {
        return await _userService.GetAsync();
    } 

/// GET API return a specific user
    [HttpGet("{id}")]
    public async Task<ActionResult<User>> Get(string Id) {
        var user = await _userService.GetAsync(Id);
        if (user is null) {
            return NotFound();
        }
        return user;
    }

/// POST API add a user
    [HttpPost]
    public async Task<ActionResult> Post(User newUser) {
        await _userService.CreateAsync(newUser);
        return CreatedAtAction(nameof(Get), new {id = newUser.Id}, newUser);
    }

/// PUT API update a user
    [HttpPut("{id}")]
    public async Task<ActionResult> Update(string Id, User updatedUser) {
        bool updated = await _userService.UpdateAsync(Id, updatedUser);
        if (!updated) {
            // this assumes that a failed update is always caused by the object 
            // not being found. This needs to be changed if the cause may be different
            return NotFound();
        } 
        return NoContent();
    }


/// DELETE API delete a user
    [HttpDelete("{id}")]
    public async Task<ActionResult> Delete(string Id) {
        var user = await _userService.GetAsync(Id);
        if (user is null) {
            return NotFound();
        }
        await _userService.DeleteAsync(user.Id);
        return NoContent();
    }
}