module?.exports =
  getInitialState: ->
    validationErrors: []

  setValidationErrors: (text) ->
    errors = @getValidationErrors(text)
    @setState validationErrors: errors
    !!errors.length

  getValidationErrors: (text) ->
    @validations.reduce (errors, validation) ->
      if validation.check(text)
        return errors.concat validation.error
      errors
    , []
