using ecommerceapp.models;
using ecommerceapp.services;
using Microsoft.AspNetCore.Mvc;

namespace ecommerceapp.controllers;

[ApiController]
[Route("api/[controller]")]
[Produces("application/json")]
public class QuestionController : ControllerBase{
    private readonly QuestionService _questionService;
    public QuestionController(QuestionService questionService) {
        this._questionService = questionService;
    }

// GET API return a list of questions
    [HttpGet]
    public async Task<List<Question>> Get() {
        return await _questionService.GetAsync();
    } 

// GET API return a specific question
    [HttpGet("{id}")]
    public async Task<ActionResult<Question>> Get(string Id) {
        var question = await _questionService.GetAsync(Id);
        if (question is null) {
            return NotFound();
        }
        return question;
    }

// POST API add a question
    [HttpPost]
    public async Task<ActionResult> Post(Question newQuestion) {
        await _questionService.CreateAsync(newQuestion);
        return CreatedAtAction(nameof(Get), new {id = newQuestion.Id}, newQuestion);
    }

/// PUT API update a question
    [HttpPut("{id}")]
    public async Task<ActionResult> Update(string Id, Question updatedQuestion) {
        bool updated = await _questionService.UpdateAsync(Id, updatedQuestion);
        if (!updated) {
            // this assumes that a failed update is always caused by the object 
            // not being found. This needs to be changed if the cause may be different
            return NotFound();
        } 
        return NoContent();
    }

/// DELETE API delete a question
    [HttpDelete("{id}")]
    public async Task<ActionResult> Delete(string Id) {
        var question = await _questionService.GetAsync(Id);
        if (question is null) {
            return NotFound();
        }
        await _questionService.DeleteAsync(question.Id);
        return NoContent();
    }
}