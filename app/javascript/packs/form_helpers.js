
document.addEventListener('turbolinks:load', ()=>{
    $('#form-submit').on('click', (event)=>{
        event.preventDefault()
        console.log('form submitted')
        forms = document.forms
        Array.from(forms).forEach((form)=>{
            console.log(form)
            fd = new FormData(form)
            entries = Object.fromEntries(fd)
            // setTimeout(()=>{
            $.ajax({
                url: form.getAttribute('action'),
                method: "POST",
                data: entries,
                success:(response)=>{
                    console.log('success')
                },
                error:(XMLHttpRequest, textStatus, errorThrown)=>{
                    console.log('text status: '+ textStatus+', error thrown: '+ errorThrown+' xml: '+XMLHttpRequest.responseText)
                }
            })
            // }, 000)
        })
        console.log('finished')
        setTimeout(()=>{
            window.location.reload()
        }, 2000)
    })
    $('#new-field').on('click', ()=>{
        temp = document.getElementById('form-fields')
        type = document.getElementById('to-be-added-field').value
        form_id = document.getElementById('form-id')
        $.ajax({
            url: '/forms/add_new_field',
            method: "POST",
            data: {"type": type, "id":form_id.value },
            success:(response)=>{
                var div = document.createElement('div')
                div.innerHTML = response
                console.log('success')
                temp.append(div)
            },
            error:(XMLHttpRequest, textStatus, errorThrown)=>{
                console.log('text status: '+ textStatus+', error thrown: '+ errorThrown+' xml: '+XMLHttpRequest.responseText)
            }
        })
    })
    document.body.addEventListener('click', (event)=>{
        if(event.target.id=="add-radio-option"){
            $.ajax({
                url: '/radio_button_options/new',
                method: "GET",
                success:(response)=>{
                    var div = document.createElement('div')
                    div.innerHTML = response
                    $('#radio-option-section').append(div)
                    $('.delete-radio-option').on('click', (event)=>{
                        event.target.parentNode.remove()
                    })
                },
                error:(XMLHttpRequest, textStatus, errorThrown)=>{
                    console.log('text status: '+ textStatus+', error thrown: '+ errorThrown+' xml: '+XMLHttpRequest.responseText)
                }
            })
            
        }
    })

})