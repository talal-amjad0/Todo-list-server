class TasksController < ApplicationController
        # GET /tasks
        def index
          @tasks = Task.all
          render json: @tasks
        end
      
        # GET /tasks/:id
        def show
          @task = Task.find(params[:id])
          render json: @task
        end
      
        # POST /tasks
        def create
            # Parse the request body to get the JSON data
            request_body = JSON.parse(request.body.read)
        
            # Create a new task using the parsed data
            @task = Task.new(request_body)
        
            if @task.save
              render json: @task, status: :created
            else
              render json: @task.errors, status: :unprocessable_entity
            end
        end
      
        # /PUT /tasks/:id
        def update
          @task = Task.find_by(id: params[:id])
          if @task
            request_body = JSON.parse(request.body.read)
            if @task.update(request_body)
              render json: @task
            else
              render json: @task.errors, status: :unprocessable_entity
            end
          else
            render json: {message: 'Task not found'}, status: :not_found
          end

        rescue StandardError => e
          render json: {error: e.message}, status: :internal_server_error
        end
      
        # DELETE /tasks/:id
        def destroy
          # debugger
          @task = Task.find_by(id: params[:id])

          if @task
            @task.destroy
            render json: {message: 'Task deleted Successfully'}, status: :ok
          else
            render json: {message: 'Task not found'}, status: :not_found
          end

        rescue StandardError => e
          render json: {error: e.message}, status: :internal_server_error
        end
      
        private
      
        # Only allow a trusted parameter "white list" through.
        def task_body
            permit(:task, :due_date, :status)
        end   
end
