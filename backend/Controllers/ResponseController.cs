using ecommerceapp.models;
using ecommerceapp.services;
using Microsoft.AspNetCore.Mvc;

namespace ecommerceapp.controllers;

[ApiController]
[Route("api/[controller]")]
[Produces("application/json")]
public class ResponseController : ControllerBase{
    private readonly ResponseService _responseService;
    public ResponseController(ResponseService responseService) {
        this._responseService = responseService;
    }

// GET API return a list of responses
    [HttpGet]
    public async Task<List<Response>> Get() {
        return await _responseService.GetAsync();
    } 

// GET API return a specific response
    [HttpGet("{Id}")]
    public async Task<ActionResult<Response>> Get(string Id) {
        var response = await _responseService.GetAsync(Id);
        if (response is null) {
            return NotFound();
        }
        return response;
    }

// POST API add a response
    [HttpPost]
    public async Task<ActionResult> Post(Response newResponse) {
        await _responseService.CreateAsync(newResponse);
        return CreatedAtAction(nameof(Get), new {id = newResponse.Id}, newResponse);
    }

// PUT API update a response
    [HttpPut("{id}")]
    public async Task<ActionResult> Update(string Id, Response updatedResponse) {
        bool updated = await _responseService.UpdateAsync(Id, updatedResponse);
        if (!updated) {
            // this assumes that a failed update is always caused by the object 
            // not being found. This needs to be changed if the cause may be different
            return NotFound();
        } 
        return NoContent();
    }


/// DELETE API delete a response
    [HttpDelete("{id}")]
    public async Task<ActionResult> Delete(string Id) {
        var response = await _responseService.GetAsync(Id);
        if (response is null) {
            return NotFound();
        }
        await _responseService.DeleteAsync(response.Id);
        return NoContent();
    }
}